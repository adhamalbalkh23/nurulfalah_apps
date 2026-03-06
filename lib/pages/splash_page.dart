import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/bottomnavbar_global.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages/landing_page.dart';
import 'package:nurulfalah_apps/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    await Future.delayed(Duration(seconds: 5));
    bool? data = await PreferenceHandler.getIsLogin();
    if (data == true) {
      context.pushAndRemoveAll(Bottomnavbar(role: "user"));
    } else {
      context.pushAndRemoveAll(Landingpage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/Landing Page.png",
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo app.png",
                  height: 316,
                  width: 316,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
