import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("My App"),
        Row(
          children: const [
            HeaderBtn(icon: Icons.home_outlined, headerText: "Home", routeName: "/home"),
            HeaderBtn(icon: Icons.grid_on_outlined, headerText: "Browse", routeName: '/browse'),
            HeaderBtn(icon: Icons.favorite_border_outlined, headerText: 'Favourites', routeName: '/favourite',),
            HeaderBtn(icon: Icons.settings_outlined, headerText: "Settings", routeName: "/settings"),
          ],
        ),
      ],
    );
  }
}

class HeaderBtn extends StatelessWidget {
  final IconData icon;
  final String headerText;
  final String routeName;

  const HeaderBtn({
    super.key,
    required this.icon,
    required this.headerText,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pushReplacementNamed(context, routeName),
          icon: Icon(icon),
        ),
        Text(headerText),
      ],
    );
  }
}
