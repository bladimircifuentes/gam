import 'package:flutter/material.dart';
import 'package:gam/profile/helpers/profile_page.dart';
import 'package:gam/profile/providers/profile_provider.dart';
import 'package:gam/subscription/providers/subscription_provider.dart';
//port 'package:gam/subscription/page/subcription_page.dart';
//port 'package:gam/subscription/services/subscription_services.dart';

import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder(
        future: checkSubscription(context),
        builder: (context, snapshot ){
          return const Center(
           child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Image(image: AssetImage('assets/main_logo.png'),height: 50),
              SizedBox(height: 10),
              CircularProgressIndicator()
             ],
           ),
          );
        },
      ),
    );
  }

  Future checkSubscription(BuildContext context) async {
    SubscriptionProvider subscriptionProvider = Provider.of<SubscriptionProvider>(context,listen: false);
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    await Future.delayed(const Duration(seconds: 2));

    bool existSubscription =await subscriptionProvider.checkSubscription();
    await profileProvider.checkProfile();

    if(context.mounted && !existSubscription){
      Navigator.pushNamedAndRemoveUntil(context, 'subscripcion', (route) => false);
      return;
    }

    if(context.mounted && !profileProvider.existUsuario){
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      return;
    }
    if(context.mounted){
      Navigator.pushNamedAndRemoveUntil(context, ProfilePage.profile(profileProvider.rol!), (route) => false);
    }
  }

}