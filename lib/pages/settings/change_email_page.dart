import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprinter_mobile/components/sprinter_button.dart';
import 'package:sprinter_mobile/components/sprinter_text_field.dart';
import 'package:sprinter_mobile/utils/dio.dart';
import 'package:sprinter_mobile/utils/secure_storage.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final TextEditingController newEmailController = TextEditingController();

  String? newEmailErrorText;

  @override
  void initState() {
    super.initState();
    // Clears any errors once the user starts making edits to email text field
    newEmailController.addListener(
      () => setState(
        () => newEmailErrorText = null,
      ),
    );
  }

  void changeEmail() async {
    setState(() {
      newEmailErrorText = null;
    });

    final newEmail = newEmailController.text.trim();

    if (newEmail.isEmpty) {
      setState(() {
        newEmailErrorText = 'New email not provided';
      });
      return;
    }

    if (!newEmail.contains('@') || !newEmail.contains('.')) {
      setState(() {
        newEmailErrorText = 'Please enter a valid email address';
      });
      return;
    }

    final Map<String, String> data = {
      'email': newEmail,
    };

    try {
      final String? accessToken = await getAccessToken();

      if (accessToken == null) return;

      final response = await dio.put(
        '/account/email',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: data,
      );

      final newAccessToken = response.data['accessToken'];

      await storeAccessToken(newAccessToken);

      context.pop();
    } on DioException catch (error) {
      if (error.response != null && error.response?.statusCode == 400) {
        setState(() {
          newEmailErrorText = error.response?.data;
        });
        return;
      }

      setState(() {
        newEmailErrorText = 'Server currently down. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Change Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(height: 32),
                SprinterTextField(
                  hintText: 'New Email',
                  controller: newEmailController,
                  icon: Icons.email,
                  errorText: newEmailErrorText,
                ),
                const SizedBox(height: 32),
                SprinterButton(
                  onTap: changeEmail,
                  data: 'Change Email',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
