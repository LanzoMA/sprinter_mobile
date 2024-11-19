import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sprinter_mobile/components/sprinter_button.dart';
import 'package:sprinter_mobile/components/sprinter_text_field.dart';
import 'package:sprinter_mobile/pages/home_page.dart';
import 'package:sprinter_mobile/pages/sign_up_page.dart';
import 'package:sprinter_mobile/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailErrorMessage;
  String? passwordErrorMessage;

  void login() async {
    setState(() {
      emailErrorMessage = passwordErrorMessage = null;
    });

    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty) emailErrorMessage = 'No email provided';
    if (password.isEmpty) passwordErrorMessage = 'No password provided';

    if (email.isEmpty || password.isEmpty) {
      setState(() {});
      return;
    }

    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    try {
      await dio.post('/login', data: data);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on DioException catch (error) {
      if (error.response != null && error.response?.statusCode == 401) {
        setState(() {
          passwordErrorMessage = 'Incorrect email/password';
        });
        return;
      }

      setState(() {
        passwordErrorMessage = 'Server currently down. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterTextField(
                      hintText: 'Email',
                      controller: emailController,
                      icon: Icons.email,
                      errorText: emailErrorMessage,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                      icon: Icons.password,
                      errorText: passwordErrorMessage,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterButton(
                      onTap: login,
                      data: 'Login',
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No account? '),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
