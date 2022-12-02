import 'package:flutter/material.dart';
import 'package:superstore_supplier_side/main.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';
import 'package:superstore_supplier_side/views/auth/login_screen.dart';
import 'package:superstore_supplier_side/views/auth/sign_up_screen.dart';
import 'package:superstore_supplier_side/views/auth/widgets/entering_btn.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "SuperStore\nSupplier Side",
              textAlign: TextAlign.center,
              style: AppTextStyles.MAIN_SPLASH_HEADING,
            ),
          ),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              EnteringButton(
                  onPressed: () {
                    navigateToPage(context, LoginScreen());
                  },
                  title: "Login"),
              SizedBox(width: 0),
              EnteringButton(
                onPressed: () {
                  navigateToPage(context, SignUpScreen());
                },
                title: "Sign Up",
              ),
            ],
          )
        ],
      ),
    );
  }
}
