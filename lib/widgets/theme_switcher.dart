import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shm/provider/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return IconButton(
          onPressed: () {
            themeProvider.setDarkMode();
          },
          icon: Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 10.0,
            ),
            child: Icon(
              themeProvider.isDarkMode
                  ? Icons.brightness_2
                  : Icons.brightness_4,
              size: 25,
            ),
          ));
    });
  }
}
