import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Image.asset(
              'assets/images/scholar.png',
            ),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'pacifico',
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(labelText: 'Email'),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(labelText: 'Password'),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onPressed: () {},
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
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
