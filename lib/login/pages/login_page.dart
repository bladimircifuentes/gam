import 'package:flutter/material.dart';
import 'package:gam/common/global/environment_provider.dart';
import 'package:gam/common/widgets/widgets.dart';
import 'package:gam/login/providers/providers.dart';
import 'package:gam/profile/helpers/profile_page.dart';
import 'package:gam/profile/providers/providers.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height *0.9,
                child: Column(
                  children: [
                    const LogoEstablishment(),
                    _form(email, password, auth, context),
                    const SizedBox(height: 15,),
                    GestureDetector(
                      onTap: null,
                      child: const Text(
                        '¿Has olvidado tu contraseña?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      },
    );
  }

  Container _form(TextEditingController email, TextEditingController password, AuthProvider auth, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children:[
          CustomInput(
            hintText: 'Email', 
            keyboardType: TextInputType.emailAddress, 
            obscureText: false, 
            prefix: Icons.email,
            textController: email,
          ),
          CustomInput(
            hintText: 'Password', 
            obscureText: true, 
            prefix: Icons.key,
            textController: password,
          ),
          BtnBlue(
            texto: 'Iniciar Sesion',
            onPressed: auth.state == 2 ? null :() async {
              await _sendData(context, email.text.trim(), password.text.trim(),auth);
            } 
          ),
        ],
      ),
    );
  }

  _sendData(context, String email, String password, AuthProvider authProvider) async{
    if(email.isEmpty){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'El correo es obligatorio', 
          onPressed: (){}
        )
      );
      return;
    }
    if(password.isEmpty){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'La contraseña es obligatoria', 
          onPressed: (){}
        )
      );
      return;
    }
    final apiUrl = Provider.of<EnvironmentProvider>(context, listen: false).apiUrl;
    await authProvider.login(
      apiUrl: apiUrl,
      email: email,
      password: password
    );

    if(authProvider.state == 4){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Datos incorrectos', 
          onPressed: (){}
        )
      );
      return;
    }

    if(authProvider.state == 5){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'El servicio no esta disponible, intente mas tarde', 
          onPressed: (){}
        )
      );
      return;
    }

    if(authProvider.state == 3){
      await authProvider.loginSucces();
      final profileProvider = Provider.of<ProfileProvider>(context,listen: false);
      await profileProvider.checkProfile();
      Navigator.pushNamedAndRemoveUntil(context, ProfilePage.profile(profileProvider.rol!), (route) => false);
    }
  }
}