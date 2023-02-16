import 'package:flutter/material.dart';
import 'package:hotshot/constants/constants.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/services/google_auth.dart';
import 'package:hotshot/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    final themeProvider = Provider.of<ThemeProvider>(context);

    final name = user!.fullName ?? 'user';
    final email = user.email ?? 'email';
    final profile = user.profile ?? '';

    return Drawer(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 60,
              foregroundImage: NetworkImage(profile),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              email,
              style: TextStyle(),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 0.8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      style: drawerButtonStyle,
                      label: const Text('Order History'),
                      icon: const Icon(Icons.history_rounded),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      style: drawerButtonStyle,
                      label: const Text('Insights'),
                      icon: const Icon(Icons.auto_graph_rounded),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(!themeProvider.isDarkMode);
                      },
                      style: drawerButtonStyle,
                      label: Text(themeProvider.isDarkMode
                          ? 'Light Mode'
                          : 'Dark Mode'),
                      icon: themeProvider.isDarkMode
                          ? const Icon(Icons.sunny)
                          : const Icon(Icons.nightlight_round),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      style: drawerButtonStyle,
                      label: const Text('Rate Us'),
                      icon: const Icon(Icons.star_rate_rounded),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          GoogleAuthentication().googleLogout();
                        },
                        style: drawerButtonStyle,
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
