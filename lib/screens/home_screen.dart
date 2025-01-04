import 'package:flutter/material.dart';
import 'package:shm/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Appbar(
        isFirstPage: true,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
