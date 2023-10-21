import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gam/common/global/environment_provider.dart';
import 'package:gam/common/widgets/widgets.dart';
import 'package:gam/login/providers/providers.dart';
import 'package:gam/profile/providers/profile_provider.dart';
import 'package:gam/settings/providers/providers.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool errorConfirmPassword = false;
  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cambiar contraseña'
        ),
      ),
      body: Consumer<PasswordProvider>(
        builder: (context, password, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height *0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElementContainer(
                        elements: [
                          const ShowExpandableInformation(
                            titulo: 'Nota', 
                            contenido: 'Al momento de cambiar la contraseña se cerrará la sesión actual.'
                          ),
                          const SizedBox(height: 12),
                          CustomInput(
                            hintText: 'Contraseña actual', 
                            prefix: Icons.password, 
                            textController: _oldPassword,
                            obscureText: obscureOldPassword,
                            suffixIcon: IconButton(
                              onPressed: () => setState( () => obscureOldPassword = !obscureOldPassword), 
                              icon: Icon(obscureOldPassword ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),

                          CustomInput(
                            hintText: 'Nueva contraseña', 
                            prefix: Icons.password, 
                            textController: _newPassword,
                            obscureText: obscureNewPassword,
                            suffixIcon: IconButton(
                              onPressed: () => setState( () => obscureNewPassword = !obscureNewPassword), 
                              icon: Icon(obscureNewPassword ? Icons.visibility : Icons.visibility_off),
                            )
                          ),

                          CustomInput(
                            hintText: 'Confirmar nueva contraseña', 
                            prefix: Icons.password, 
                            textController: _confirmPassword,
                            obscureText: obscureConfirmPassword,
                            suffixIcon: IconButton(
                              onPressed: () => setState( () => obscureConfirmPassword = !obscureConfirmPassword), 
                              icon: Icon(obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                            )
                          ),
                          BtnBlue(
                            texto: 'Cambiar contraseña', 
                            onPressed:  password.state ==2 ? null : () async{
                              if(!await _validate(context)) return;
                              
                              if(mounted){
                                await _sendData(
                                  context: context,
                                  newPassword: _newPassword.text.trim(),
                                  oldPassword: _oldPassword.text.trim(),
                                  password: password
                                );
                              }
                            }
                          ),
                        ]
                      )
                    ),
                  ],
                ),
              ),
            )
          );
        }
      ),
    );
  }
  Future<void> _sendData({
    required String oldPassword,
    required String newPassword, 
    required BuildContext context, 
    required PasswordProvider password
  }) async{

    final url = context.read<EnvironmentProvider>().apiUrl;
    final email = context.read<ProfileProvider>().usuario!.email;

    await password.changePassword(
      url: url, 
      email: email, 
      oldPassword: oldPassword, 
      newPassword: newPassword,
    );
    
    if(context.mounted && password.state == 3){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Exito', 
          content: 'Contraseña cambiada', 
          onPressed: () async{
            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
            await context.read<AuthProvider>().logout();

            if(mounted){
              await context.read<ProfileProvider>().checkProfile();
            }
            
          }
        )
      );
    }
    if(context.mounted && password.state == 4){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'La contraseña actual incorrecta', 
          onPressed: (){}
        )
      );
    }
    if(context.mounted && password.state == 5){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'El servicio no esta disponible, intente mas tarde', 
          onPressed: (){}
        )
      );
    }
  }

  Future<bool> _validate(BuildContext context) async{

    if(_oldPassword.text.trim().isEmpty){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Ingrese su contraseña actual', 
          onPressed: (){}
        )
      );
      return false;
    }

    if(_newPassword.text.trim().isEmpty){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Ingrese la nueva contraseña', 
          onPressed: (){}
        )
      );
      return false;
    }

    if(_confirmPassword.text.trim().isEmpty){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Ingrese la contraseña de confirmacion', 
          onPressed: (){}
        )
      );
      return false;
    }

    if(_confirmPassword.text.trim() != _newPassword.text.trim()){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Las contraseñas no coinciden.', 
          onPressed: (){
            setState(() {
              errorConfirmPassword = true;
            });
          }
        )
      );
      return false;
    }

    return true;
  }
}