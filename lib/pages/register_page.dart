import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password;
  bool isloading = false;

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
                    'REGISTER',
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                        },
                        labelText: 'Email',
                        onChanged: (data) => email = data,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field is required';
                          }
                        },
                        labelText: 'Password',
                        onChanged: (data) => password = data,
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
                      await userRegister();

                      Navigator.pop(context);
                      customSnackBar(context, Colors.green, 'User Registered');
                    } on FirebaseAuthException catch (ex) {
                      if (ex.code == 'invalid-email') {
                        customSnackBar(context, Colors.red, 'Invalid Email');
                      } else if (ex.code == 'weak-password') {
                        customSnackBar(context, Colors.red,
                            'The password provided is too weak.');
                      } else if (ex.code == 'email-already-in-use') {
                        customSnackBar(context, Colors.red,
                            'The account already exists for that email.');
                      }
                    } catch (ex) {
                      customSnackBar(context, Colors.red,
                          'There is an error, please try again');
                    }
                    isloading = false;
                    setState(() {});
                  }
                },
                text: 'Register',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ))
                ],
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> userRegister() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
