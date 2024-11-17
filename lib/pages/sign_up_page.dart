import 'package:flutter/material.dart';
import 'package:sprinter_mobile/components/sprinter_text_field.dart';
import 'package:sprinter_mobile/pages/home_page.dart';
import 'package:sprinter_mobile/pages/login_page.dart';
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

  String emailErrorMessage = '';
  String usernameErrorMessage = '';
  String passwordErrorMessage = '';
  String confirmPasswordErrorMessage = '';

  void signUp() async {
    setState(() {
      emailErrorMessage = usernameErrorMessage =
          passwordErrorMessage = confirmPasswordErrorMessage = '';
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
      final response = await dio.post(
        '$url/register',
        data: data,
      );

      if (response.statusCode != 200) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      print(error);
      setState(() {
        emailErrorMessage = 'Account already registed with this email';
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
                  const Text('Sign Up'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterTextField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                  ),
                  Visibility(
                    visible: emailErrorMessage.isNotEmpty,
                    child: Text(
                      emailErrorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterTextField(
                      hintText: 'Username',
                      controller: usernameController,
                    ),
                  ),
                  Visibility(
                    visible: usernameErrorMessage.isNotEmpty,
                    child: Text(
                      usernameErrorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterTextField(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController,
                    ),
                  ),
                  Visibility(
                    visible: passwordErrorMessage.isNotEmpty,
                    child: Text(
                      passwordErrorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SprinterTextField(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      controller: confirmPasswordController,
                    ),
                  ),
                  Visibility(
                    visible: confirmPasswordErrorMessage.isNotEmpty,
                    child: Text(
                      confirmPasswordErrorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: signUp,
                    child: const Text('Sign Up'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
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
