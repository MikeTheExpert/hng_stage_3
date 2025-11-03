import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  final double size = 15;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: 1440,
        height: 98,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 47,),
                SvgPicture.asset(
                  'assets/icons/appIcon.svg',
                  width: 16,
                  height: 16,
                ),
                const Text("Wallpaper Studio",style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                ),
              ],
            ),
            SizedBox(
              width: 523,
              height: 44,
              child: Row(
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
            ),
          ],
        ),
      ),
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
    final bool isCurrentPage = ModalRoute.of(context)?.settings.name == routeName;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isCurrentPage ? Colors.black12 : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: () => Navigator.pushReplacementNamed(context, routeName),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 6),
            Text(headerText, style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),),
          ],
        ),
      ),
    );
  }
}

