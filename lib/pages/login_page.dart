import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'LoginPage';
  bool isloading = false;

  String? email, password;

  bool ispassword = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginILoadingStete) {
            isloading = true;
          } else if (state is LoginSuscessStete) {
            isloading = false;
            BlocProvider.of<ChatCubit>(context).getMessages();
            Navigator.pushNamed(context, ChatPage.id);
          } else if (state is LoginFailureStete) {
            customSnackBar(context, Colors.red, state.errorMessage);
            isloading = false;
          }
          //mariamattef656@gmail.com
          // 123456
        },
        builder: (context, state) => ModalProgressHUD(
              inAsyncCall: isloading,
              child: Scaffold(
                backgroundColor: kPrimaryColor,
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      Image.asset(kLogo),
                      const Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'pacifico',
                        ),
                      ),
                      const Spacer(flex: 1),
                      const Row(
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                                  if (value!.isEmpty) {
                                    return 'Email is required';
                                  }
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
                                    },
                                    child: ispassword
                                        ? const Icon(
                                            Icons.visibility,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.visibility_off,
                                            color: Colors.white,
                                          )),
                                labelText: 'Password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  }
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
                            BlocProvider.of<AuthBloc>(context).add(
                                LoginEvent(email: email!, password: password!));
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
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
            ));
  }
}
