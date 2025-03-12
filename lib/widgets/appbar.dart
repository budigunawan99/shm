import 'package:flutter/material.dart';
import 'package:shm/widgets/inventory_menu.dart';
import 'package:shm/widgets/theme_switcher.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isFirstPage;
  final String? title;
  const Appbar({super.key, required this.isFirstPage, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleOptions(title),
      leading: leadingOptions(context),
      actions: isFirstPage
          ? const [
              InventoryMenu(),
              ThemeSwitcher(),
            ]
          : const [
              ThemeSwitcher(),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget? leadingOptions(context) {
    if (isFirstPage) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 11.0,
          right: 11.0,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    }
  }

  Widget titleOptions(title) {
    if (title == null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 11.0,
        ),
        child: Image.asset(
          "images/shm_title.png",
          width: 62.86,
          height: 20.66,
        ),
      );
    } else {
      return Text(title);
    }
  }
}
