import 'package:flutter/material.dart';
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

  void login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) return;

    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    try {
      final response = await dio.post('$url/login', data: data);

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
            const Text('Login'),
            const SizedBox(height: 16),
            SprinterTextField(
              hintText: 'Email',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            SprinterTextField(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            TextButton(
              onPressed: login,
              child: const Text('Login'),
            ),
            Row(
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
