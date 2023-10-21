import 'package:flutter/material.dart';
import 'package:gam/common/global/environment_provider.dart';
import 'package:gam/common/widgets/widgets.dart';

import 'package:gam/settings/providers/providers.dart';
import 'package:provider/provider.dart';

class ForgottenPasswordPage extends StatelessWidget {
  const ForgottenPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    return Scaffold(
      body: Consumer<PasswordProvider>(
        builder: (context, password, child){
          return SafeArea(
            child: SingleChildScrollView(
               child: SizedBox(
                  height: MediaQuery.of(context).size.height *0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoEstablishment(),
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          children: [
                            CustomInput(
                              hintText: 'Correo Electronico', 
                              prefix: Icons.email, 
                              textController: email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            BtnBlue(
                              texto: 'Restablecer contraseña', 
                              onPressed: password.state ==2 ? null : () async{
                                await _senData(email.text, context, password);
                              },
                            )
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

  Future<void> _senData(String email, BuildContext context, PasswordProvider password) async{
    String url = context.read<EnvironmentProvider>().apiUrl;
    if(email.isEmpty) return;

    await password.restorePassword(url, email.trim());
    if(context.mounted && password.state == 3){

      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Exito', 
          content: 'La contraeña fue restablecida, revisa tu correo', 
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false)
        )
      );
      return;
    }
    if(context.mounted && password.state == 4){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Correo no valido', 
          onPressed: (){}
        )
      );
      return;
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
}