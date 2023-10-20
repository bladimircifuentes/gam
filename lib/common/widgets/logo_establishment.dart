import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gam/subscription/providers/subscription_provider.dart';

class LogoEstablishment extends StatelessWidget {
  const LogoEstablishment({super.key});


  @override
  Widget build(BuildContext context) {
    final SubscriptionProvider subscriptionProvider = Provider.of<SubscriptionProvider>(context,listen: false);
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: 250,
        child: Column(
          children: [
            subscriptionProvider.existLogo 
            ? Image.file(subscriptionProvider.logo,width: 170,)
            :const Image(image: AssetImage('assets/main_logo.png'),height: 170),
            const SizedBox(height: 20,),
             Text(
              subscriptionProvider.subscriptionModel.customer.fullName,
              style: const TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}