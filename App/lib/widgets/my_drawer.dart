import 'package:flutter/material.dart';
import 'package:hotshot/constants/constants.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/screens/PendingOrders.dart';
import 'package:hotshot/screens/feedback.dart';
import 'package:hotshot/screens/ordHistory.dart';
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

    final name = (user ?? dummyUser).fullName ?? 'user';
    final email = (user ?? dummyUser).email ?? 'email';
    final profile = (user ?? dummyUser).profile ?? '';

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
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrdHistory(),
                            ));
                      },
                      style: drawerButtonStyle,
                      label: const Text('Order History'),
                      icon: const Icon(Icons.history_rounded),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.pending_actions_rounded),
                      label: const Text('Pending Orders'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PendHistory(),
                            ));
                      },
                    ),
                    // TextButton.icon(
                    //   onPressed: () {},
                    //   style: drawerButtonStyle,
                    //   label: const Text('Insights'),
                    //   icon: const Icon(Icons.auto_graph_rounded),
                    // ),
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
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => feedback(),
                            ));
                      },
                      style: drawerButtonStyle,
                      label: const Text('Feedback'),
                      icon: const Icon(Icons.star_rate_rounded),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
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
