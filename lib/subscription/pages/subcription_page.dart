import 'package:flutter/material.dart';
import 'package:gam/common/global/environment.dart';
import 'package:gam/common/widgets/widgets.dart';
import 'package:gam/subscription/providers/subscription_provider.dart';
//import 'package:gam/core/helpers/helpers.dart';
//import 'package:gam/subscription/helpers/show_alert.dart';
//import 'package:gam/subscription/widgets/widgets.dart';
//import 'package:gam/ui/views/login_page.dart';
import 'package:provider/provider.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController codigo = TextEditingController();
    return Scaffold(
      body: Consumer<SubscriptionProvider>(
        builder: (context, subscription, child) {  
          return SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height *0.7,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Logo(titulo: 'Xecasoft'),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          CustomInput(
                              hintText: 'Codigo', 
                              prefix: Icons.numbers, 
                              textController: codigo,
                              keyboardType: TextInputType.number,
                            ),
                          BtnBlue(
                            texto: 'Enviar', 
                            onPressed: subscription.state == 2 ? null : () async{
            
                              if(codigo.text.trim().isEmpty) return;
            
                              await subscription.subscribe(codigo.text.trim());
                              
                              if(context.mounted && subscription.state == 3){
                                String url = subscription.subscriptionModel.url;
                                debugPrint('URL: $url');
                                Environment.changeUrl(subscription.subscriptionModel.url);

                                subscription.successSubscription();

                                Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);

                              }
                              if(context.mounted && subscription.state == 4){
                                showDialog(
                                  context: context,
                                  builder: (context) =>  InformDialog(
                                    title: 'Error', 
                                    content: 'Codigo incorrecto', 
                                    onPressed: (){}
                                  )
                                );
                              }
                              if(context.mounted && subscription.state == 5){
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ) ,
              ),
            ),
          );
        },
      ),
    );
  }
}