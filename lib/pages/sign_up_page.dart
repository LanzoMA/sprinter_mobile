import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sprinter_mobile/components/sprinter_text_field.dart';
import 'package:sprinter_mobile/pages/home_page.dart';
import 'package:sprinter_mobile/pages/login_page.dart';

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

  void signUp() async {
    final Dio dio = Dio();

    final String email = emailController.text.trim();
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    final bool isAnyFieldEmpty = email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty;

    if (isAnyFieldEmpty) return;
    if (password != confirmPassword) return;
    if (password.length < 8) return;

    final Map<String, String> data = {
      'email': email,
      'username': username,
      'password': password,
    };

    try {
      final response = await dio.post(
        'http://192.168.223.200:5000/register',
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign Up'),
            const SizedBox(height: 16),
            SprinterTextField(
              hintText: 'Email',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            SprinterTextField(
              hintText: 'Username',
              controller: usernameController,
            ),
            const SizedBox(height: 16),
            SprinterTextField(
              hintText: 'Password',
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            SprinterTextField(
              hintText: 'Confirm Password',
              obscureText: true,
              controller: confirmPasswordController,
            ),
            TextButton(
              onPressed: signUp,
              child: const Text('Sign Up'),
            ),
            Row(
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
    );
  }
}
