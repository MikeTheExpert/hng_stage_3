import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  final double size = 15;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("My App"),
        Row(
          children: [
            HeaderBtn(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: size,
                height: size,
              ),
              headerText: "Home",
              routeName: "/home",
            ),
            HeaderBtn(
              icon: SvgPicture.asset(
                'assets/icons/browse.svg',
                width: size,
                height: size,
              ),
              headerText: "Browse",
              routeName: '/browse',
            ),
            HeaderBtn(
              icon: SvgPicture.asset(
                'assets/icons/favourite.svg',
                width: size,
                height: size,
              ),
              headerText: 'Favourites',
              routeName: '/favourite',
            ),
            HeaderBtn(
              icon: SvgPicture.asset(
                'assets/icons/settings.svg',
                width: size,
                height: size,
              ),
              headerText: "Settings",
              routeName: "/settings",
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderBtn extends StatelessWidget {
  final SvgPicture icon;
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
          focusColor: Color.fromRGBO(245, 245, 245, 1),
          hoverColor: Colors.transparent,
          onPressed: () => Navigator.pushReplacementNamed(context, routeName),
          icon: icon,
        ),
        Text(headerText),
      ],
    );
  }
}
