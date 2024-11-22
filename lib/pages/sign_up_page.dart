import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprinter_mobile/components/sprinter_button.dart';
import 'package:sprinter_mobile/components/sprinter_text_field.dart';
import 'package:sprinter_mobile/utils/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? emailErrorMessage;
  String? usernameErrorMessage;
  String? passwordErrorMessage;
  String? confirmPasswordErrorMessage;

  void signUp() async {
    setState(() {
      emailErrorMessage = usernameErrorMessage =
          passwordErrorMessage = confirmPasswordErrorMessage = null;
    });

    final String email = emailController.text.trim();
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty) emailErrorMessage = 'No email is provided';
    if (username.isEmpty) usernameErrorMessage = 'No username is provided';
    if (password.isEmpty) passwordErrorMessage = 'No password is provided';
    if (confirmPassword.isEmpty) {
      confirmPasswordErrorMessage = 'No password is provided';
    }

    final bool isAnyFieldEmpty = email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty;

    if (isAnyFieldEmpty) {
      setState(() {});
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        emailErrorMessage = 'Please enter a valid email';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        confirmPasswordErrorMessage = 'Passwords do not match';
      });
      return;
    }

    if (password.length < 8) {
      setState(() {
        passwordErrorMessage = 'Password is less than 8 characters';
      });
      return;
    }

    final Map<String, String> data = {
      'email': email,
      'username': username,
      'password': password,
    };

    try {
      await dio.post(
        '/register',
        data: data,
      );

      context.go('/home');
    } on DioException catch (error) {
      if (error.response != null && error.response?.statusCode == 400) {
        setState(() {
          emailErrorMessage = 'Account already registered with this email';
        });
        return;
      }
      setState(() {
        confirmPasswordErrorMessage =
            'Server currently down. Please try again later.';
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
                    'Sign Up',
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
                      hintText: 'Username',
                      controller: usernameController,
                      icon: Icons.person,
                      errorText: usernameErrorMessage,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterTextField(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController,
                      icon: Icons.password,
                      errorText: passwordErrorMessage,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterTextField(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      controller: confirmPasswordController,
                      icon: Icons.password,
                      errorText: confirmPasswordErrorMessage,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterButton(
                      onTap: signUp,
                      data: 'Sign Up',
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      InkWell(
                        onTap: () {
                          context.go('/login');
                        },
                        child: Text(
                          'Login',
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
