import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprinter_mobile/components/account_setting_tile.dart';
import 'package:sprinter_mobile/utils/secure_storage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  AccountSettingTile(
                    icon: Icons.email,
                    title: 'Change Email',
                    onTap: () {
                      context.push('/settings/account/email');
                    },
                  ),
                  AccountSettingTile(
                    icon: Icons.password,
                    title: 'Change Password',
                    onTap: () {
                      context.push('/settings/account/password');
                    },
                  ),
                  AccountSettingTile(
                    icon: Icons.logout,
                    title: 'Sign Out',
                    onTap: () async {
                      await deleteAccessToken();
                      context.go('/login');
                    },
                  ),
                  AccountSettingTile(
                    icon: Icons.delete,
                    title: 'Delete Account',
                    onTap: () {
                      context.push('/settings/account/delete');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
