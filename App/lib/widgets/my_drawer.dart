import 'package:flutter/material.dart';
import 'package:hotshot/constants/constants.dart';
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

  final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            const CircleAvatar(
              radius: 60,
            ),
            const SizedBox(height: 10,),
            const Text(
              'User\'s Full Name',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const Text(
              'useremail@lohit.iitg.in',
              style: TextStyle(
              ),
            ),
            const SizedBox(height: 10,),
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
                      onPressed: (){},
                      style: drawerButtonStyle,
                      label: const Text('Order History'),
                      icon: const Icon(Icons.history_rounded),
                    ),
                    TextButton.icon(
                      onPressed: (){},
                      style: drawerButtonStyle,
                      label: const Text('Insights'),
                      icon: const Icon(Icons.auto_graph_rounded),
                    ),
                    TextButton.icon(
                      onPressed: (){
                        Navigator.pop(context);
                        final provider = Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(!themeProvider.isDarkMode);
                      },
                      style: drawerButtonStyle,
                      label: Text(themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode'),
                      icon: themeProvider.isDarkMode ? const Icon(Icons.sunny) : const Icon(Icons.nightlight_round),
                    ),
                    TextButton.icon(
                      onPressed: (){},
                      style: drawerButtonStyle,
                      label: const Text('Rate Us'),
                      icon: const Icon(Icons.star_rate_rounded),
                    ),
                    TextButton.icon(
                      onPressed: (){},
                      style: drawerButtonStyle,
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout')
                    ),
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