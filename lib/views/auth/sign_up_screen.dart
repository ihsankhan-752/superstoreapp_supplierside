import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:superstore_supplier_side/controllers/auth_controller.dart';
import 'package:superstore_supplier_side/custom_widgets/buttons.dart';
import 'package:superstore_supplier_side/main.dart';
import 'package:superstore_supplier_side/utils/colors.dart';
import 'package:superstore_supplier_side/utils/text_input_decoration.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';
import 'package:superstore_supplier_side/views/auth/login_screen.dart';
import 'package:superstore_supplier_side/views/auth/splash_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  String fullName = '';
  String email = '';
  String password = '';
  String image = '';

  File? selectedImage;
  ImagePicker _picker = ImagePicker();
  Future<void> uploadImage(ImageSource source) async {
    XFile? uploadImage = await _picker.pickImage(source: source);
    if (uploadImage != null) {
      setState(() {
        selectedImage = File(uploadImage.path);
      });
    }
  }

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
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Supplier SignUp", style: AppTextStyles.MAIN_SPLASH_HEADING.copyWith(fontSize: 22)),
                      SizedBox(width: 20),
                      IconButton(icon: Icon(Icons.home_work, size: 25, color: ColorPallet.PRIMARY_PURPLE), onPressed: () => navigateToPage(context, SplashScreen())),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: ColorPallet.PRIMARY_PURPLE,
                        backgroundImage: selectedImage == null ? null : FileImage(selectedImage!),
                      ),
                      SizedBox(width: 40),
                      Column(
                        children: [
                          Container(
                            height: 40,
                            width: 45,
                            decoration: BoxDecoration(
                              color: ColorPallet.PRIMARY_PURPLE,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  uploadImage(ImageSource.camera);
                                },
                                icon: Icon(Icons.camera_alt, color: ColorPallet.PRIMARY_WHITE),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: 45,
                            decoration: BoxDecoration(
                              color: ColorPallet.PRIMARY_PURPLE,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  uploadImage(ImageSource.gallery);
                                },
                                icon: Icon(Icons.photo, color: ColorPallet.PRIMARY_WHITE),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    onSaved: (v) {
                      setState(() {
                        fullName = v!;
                      });
                    },
                    decoration: textInputDecoration.copyWith(labelText: "Full Name"),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "email Must be Filled";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (v) {
                      setState(() {
                        email = v!;
                      });
                    },
                    decoration: textInputDecoration.copyWith(labelText: "Email"),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Password Must Be Filled";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (v) {
                      setState(() {
                        password = v!;
                      });
                    },
                    decoration: textInputDecoration.copyWith(labelText: "Password"),
                  ),
                  SizedBox(height: 35),
                  provider.isLoading
                      ? CircularProgressIndicator()
                      : PrimaryButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                              provider
                                  .signUp(
                                context: context,
                                email: email,
                                password: password,
                                fullName: fullName,
                                selectedImage: selectedImage,
                                storeLogo: image,
                              )
                                  .whenComplete(() {
                                _key.currentState!.reset();
                              });
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.8,
                          btnColor: ColorPallet.AMBER_COLOR,
                          title: "Sign Up",
                        ),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () => navigateToPage(context, LoginScreen()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPallet.PRIMARY_BLACK,
                          ),
                        ),
                        Text(
                          "Sign In",
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
