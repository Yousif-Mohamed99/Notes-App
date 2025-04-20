import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 28),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(153, 67, 64, 64),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
