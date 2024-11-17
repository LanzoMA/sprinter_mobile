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

  String emailErrorMessage = '';
  String passwordErrorMessage = '';

  void login() async {
    setState(() {
      emailErrorMessage = passwordErrorMessage = '';
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
      await dio.post('$url/login', data: data);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      print(error);
      setState(() {
        passwordErrorMessage = 'Incorrect username/password';
      });
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SprinterTextField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
            ),
            Visibility(
              visible: passwordErrorMessage.isNotEmpty,
              child: Text(
                passwordErrorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
            TextButton(
              onPressed: login,
              child: const Text('Login'),
            ),
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
