import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  static const String id = 'RegisterPage';
  String? email;
  String? password;
  bool isloading = false;

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isloading = true;
        } else if (state is RegisterSuccessState) {
          isloading = false;
          Navigator.pushNamed(context, LoginPage.id);
          customSnackBar(context, Colors.green, 'User Registered');
        } else if (state is RegisterFailureState) {
          isloading = false;
          customSnackBar(context, Colors.red, state.messageError);
        }
      },
      builder: (context, state) {
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
                    kLogo,
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
                              return null;
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
                              return null;
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
                        context.read<AuthBloc>().add(
                            RegisterEvent(email: email!, password: password!));
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
      },
    );
  }

  // Future<void> userRegister() async {
  //   var auth = FirebaseAuth.instance;
  //   UserCredential user = await auth.createUserWithEmailAndPassword(
  //       email: email!, password: password!);
  // }
}
