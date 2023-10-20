import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gam/common/global/environment_provider.dart';
import 'package:gam/common/widgets/widgets.dart';
import 'package:gam/subscription/providers/subscription_provider.dart';

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
                              EnvironmentProvider environmentProvider = Provider.of<EnvironmentProvider>(context, listen: false);

                              await subscription.subscribe(codigo.text.trim(),environmentProvider.subscriptionUrl);
                              
                              if(context.mounted && subscription.state == 3){
                                
                                debugPrint('URL: ${subscription.subscriptionModel.url}');
                                environmentProvider.changeEnvironment(
                                  url: subscription.subscriptionModel.url,
                                  urlSocket: subscription.subscriptionModel.urlSocket
                                );


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