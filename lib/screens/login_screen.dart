// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vinnovate/providers/auth_provider.dart';
import 'package:vinnovate/providers/home_provider.dart';
import 'package:vinnovate/screens/home_screen.dart';
import 'package:vinnovate/utils/colors_utils.dart';
import 'package:vinnovate/utils/responsive_utils.dart';
import 'package:vinnovate/utils/validators_utils.dart';
import 'package:vinnovate/widgets/animated_button.dart';
import 'package:vinnovate/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // for responsive using media query

    double width = ResponsiveUtils.screenWidth(context);
    double height = ResponsiveUtils.screenHeight(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 40,
              )),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Consumer<AuthProvider>(
                builder: (context, authProvider, _) => Column(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: height * 0.02),
                            padding: EdgeInsets.symmetric(vertical: height * 0.05, horizontal: width * 0.04),
                            width: width * 0.9,
                            decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(width * 0.06)),
                            child: Form(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              key: formKey,
                              child: Column(
                                children: [
                                  Center(
                                      child: CircleAvatar(
                                    backgroundColor: AppColors.primaryBackgroundColor,
                                    radius: width * 0.15,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Lottie.asset(
                                        "assets/login_lottie.json",
                                        alignment: Alignment.centerLeft,
                                        addRepaintBoundary: false,
                                      ),
                                    ),
                                  )),
                                  SizedBox(height: height * 0.005),
                                  const Text(
                                    "Log In",
                                    style: TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.w500, fontSize: 25),
                                  ),
                                  TextfieldCustom(
                                      height: height,
                                      hintText: "Email",
                                      title: "Email",
                                      obscure: false,
                                      textInputAction: TextInputAction.next,
                                      textInputType: TextInputType.emailAddress,
                                      controller: emailController,
                                      validator: (value) {
                                        if (!Validate().validateEmail(value)) {
                                          return "Please Enter Email";
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icons.email_outlined),
                                  TextfieldCustom(
                                      height: height,
                                      hintText: "Password",
                                      title: "Password",
                                      obscure: authProvider.isPasswordVisible,
                                      textInputAction: TextInputAction.done,
                                      textInputType: TextInputType.visiblePassword,
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please Enter Password";
                                        } else if (value.length < 6) {
                                          return "Password should be 6 characters";
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icons.lock_outline_rounded,
                                      sufixIcon: IconButton(
                                        icon: Icon(
                                          authProvider.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          authProvider.togglePasswordVisibility();
                                        },
                                      )),
                                  SizedBox(height: height * 0.01),
                                  const Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "Forget Password?",
                                        style: TextStyle(fontSize: 16, color: AppColors.greyColor, fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: height * 0.02),
                                  CustomAnimatedButton(
                                    height: height * 0.07,
                                    width: width,
                                    controller: authProvider.buttonController,
                                    name: "Log In",
                                    ontap: () async {
                                      if (formKey.currentState!.validate()) {
                                        authProvider.buttonController.start();
                                        String? error =
                                            await authProvider.signInWithEmailAndPassword(emailController.text, passwordController.text);
                                        if (error == "success") {
                                          authProvider.buttonController.success();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.green,
                                              behavior: SnackBarBehavior.floating,
                                              margin: const EdgeInsets.all(16),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              content: const Text(
                                                "You have Successfully Logged in",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              duration: const Duration(milliseconds: 1400),
                                            ),
                                          );

                                          Timer(const Duration(seconds: 1), () {
                                            authProvider.buttonController.reset();
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => const HomeScreen(),
                                            ));
                                          });
                                        } else {
                                          authProvider.buttonController.error();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.red,
                                              behavior: SnackBarBehavior.floating,
                                              margin: const EdgeInsets.all(16),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              content: Text(
                                                error!,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              duration: const Duration(milliseconds: 1400),
                                            ),
                                          );
                                          Timer(const Duration(seconds: 1), () {
                                            authProvider.buttonController.reset();
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do not have an Account?",
                              style: TextStyle(color: AppColors.greyColor, fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            SizedBox(width: width * 0.02),
                            const Text(
                              "Sign Up",
                              style: TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        )
                      ],
                    ))));
  }
}
