import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superstore_supplier_side/controllers/auth_controller.dart';
import 'package:superstore_supplier_side/custom_widgets/buttons.dart';
import 'package:superstore_supplier_side/utils/colors.dart';
import 'package:superstore_supplier_side/utils/text_input_decoration.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';
import 'package:superstore_supplier_side/views/auth/sign_up_screen.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 150),
                  Center(child: Text("Supplier Login", style: AppTextStyles.MAIN_SPLASH_HEADING)),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (v) {
                      setState(() {
                        email = v!;
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Email must be filled";
                      } else {
                        return null;
                      }
                    },
                    decoration: textInputDecoration.copyWith(labelText: "Email"),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    onSaved: (v) {
                      setState(() {
                        password = v!;
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Password Must Be Filled";
                      } else {
                        return null;
                      }
                    },
                    decoration: textInputDecoration.copyWith(labelText: "Password"),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorPallet.PRIMARY_BLACK,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  provider.isLoading
                      ? CircularProgressIndicator()
                      : PrimaryButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                              provider.signIn(context, email, password);
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.8,
                          btnColor: Colors.amber,
                          title: "Sign In",
                        ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () => navigateToPage(context, SignUpScreen()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPallet.PRIMARY_BLACK,
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPallet.PRIMARY_PURPLE,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
