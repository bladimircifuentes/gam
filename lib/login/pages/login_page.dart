import 'package:flutter/material.dart';
import 'package:gam/common/widgets/widgets.dart';
import 'package:gam/profile/helpers/profile_page.dart';
import 'package:gam/profile/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    return Consumer<ProfileProvider>(
      builder: (context, profile, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height *0.9,
                child: Column(
                  children: [
                    const LogoEstablishment(),
                    _form(email, password, profile, context),
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

  Container _form(TextEditingController email, TextEditingController password, ProfileProvider profile, BuildContext context) {
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
            onPressed: profile.state == 2 ? null :() async {
              await _sendData(context, email.text.trim(), password.text.trim(),profile);
            } 
          ),
        ],
      ),
    );
  }

  _sendData(context, String email, String password, ProfileProvider profileProvider) async{
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
    
    await profileProvider.login(email, password);

    if(profileProvider.state == 4){
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

    if(profileProvider.state == 5){
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

    if(profileProvider.state == 3){
      await profileProvider.loginSucces();
      Navigator.pushNamedAndRemoveUntil(context, ProfilePage.profile(profileProvider.rol!), (route) => false);
    }
  }
}