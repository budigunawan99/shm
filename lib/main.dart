import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shm/model/input_data_screen_argument.dart';
import 'package:shm/provider/input_image_provider.dart';
import 'package:shm/provider/theme_provider.dart';
import 'package:shm/screens/home_screen.dart';
import 'package:shm/screens/input_data_screen.dart';
import 'package:shm/screens/inventory_screen.dart';
import 'package:shm/static/navigation_route.dart';
import 'package:shm/themes/custom_themes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SHM',
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: CustomThemes.lightThemeData,
          darkTheme: CustomThemes.darkThemeData,
          initialRoute: NavigationRoute.homeRoute.name,
          routes: {
            NavigationRoute.homeRoute.name: (context) => const HomeScreen(),
            NavigationRoute.inventoryRoute.name: (context) =>
                const InventoryScreen(),
            NavigationRoute.inputDataRoute.name: (context) =>
                ChangeNotifierProvider(
                  create: (context) => InputImageProvider(),
                  child: InputDataScreen(
                    args: ModalRoute.of(context)?.settings.arguments
                        as InputDataScreenArgument,
                  ),
                ),
          },
        );
      },
    );
  }
}
