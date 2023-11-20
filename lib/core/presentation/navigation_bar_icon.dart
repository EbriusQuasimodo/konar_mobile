import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const NavigationBarItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      label: label,
      selectedIcon: Icon(
        icon,
        color: const Color(0xff0D1F61),
        size: 35,
      ),
      icon: Icon(icon),
    );
  }
}
