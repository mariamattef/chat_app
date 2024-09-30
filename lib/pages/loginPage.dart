import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloading = false;
  String? email, password;
  bool ispassword = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Image.asset(
                KLogo,
              ),
              const Text(
                'Scholar Chat',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontFamily: 'pacifico',
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              const Row(
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        labelText: 'Email',
                        validator: (value) {
                          if (value!.isEmpty) return 'Email is required';
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        obscureText: ispassword ? false : true,
                        onChanged: (value) {
                          password = value;
                        },
                        suffixIcon: GestureDetector(
                            onTap: () {
                              ispassword = !ispassword;
                              setState(() {});
                            },
                            child: ispassword
                                ? Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.white,
                                  )),
                        labelText: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) return 'Password is required';
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    isloading = true;
                    setState(() {});
                    try {
                      await userLogin();
                      Navigator.pushNamed(context, ChatPage.id,
                          arguments: email);
                      customSnackBar(
                          context, Colors.green, 'user Logged successfully.');
                    } on FirebaseAuthException catch (ex) {
                      if (ex.code == 'invalid-email') {
                        customSnackBar(context, Colors.red, 'Invalid Email');
                      } else if (ex.code == 'user-not-found') {
                        customSnackBar(context, Colors.red,
                            'No user found for that email.');
                      } else if (ex.code == 'wrong-password') {
                        customSnackBar(context, Colors.red,
                            'Wrong password . Please try again.');
                      }
                    } catch (ex) {
                      customSnackBar(context, Colors.red,
                          'There is an error, please try again');
                    }

                    isloading = false;
                    setState(() {});
                  }
                },
                text: 'Log In',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'dont hane an account',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ))
                ],
              ),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> userLogin() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
