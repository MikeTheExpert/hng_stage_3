import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hng_stage_3/design_widgets/list_view.dart';
import 'package:hng_stage_3/design_widgets/nav_bar_widget.dart';

import '../design_widgets/home_page_card.dart';
import '../models/helper_class.dart';
import '../models/wallpaper_model.dart';

class MyBrowserPage extends StatefulWidget {
  const MyBrowserPage({super.key});

  @override
  State<MyBrowserPage> createState() => _MyBrowserPageState();
}

class _MyBrowserPageState extends State<MyBrowserPage> {
  final db = DatabaseHelper();
  List<Wallpaper> wallpapers = [];
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    _loadWallpapers();
  }

  Future<void> _loadWallpapers() async {
    final data = await db.getWallpapers();
    setState(() {
      wallpapers = data;
    });
  }

  void toggleDisplayView() {
    setState(() {
      isGrid = !isGrid;
    });
  }

  categoryPageRoute(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(child: NavBar()),

            Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 52.0, 48.0, 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ShaderMask(
                  shaderCallback:
                      (bounds) => const LinearGradient(
                    colors: [
                      Color.fromRGBO(251, 176, 59, 1),
                      Color.fromRGBO(236, 12, 67, 1),
                    ], // your two colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: const Text(
                    'Browse Wallpapers',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'ClashDisplay',
                      fontSize: 60,
                      color: Colors.white, // must be white to show gradient
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(47.0, 0.0, 47.0, 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Explore our curated collections of stunning wallpapers',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(47.0,0.0,47.0,10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: toggleDisplayView,
                    icon:
                    isGrid
                        ? SvgPicture.asset(
                      'assets/icons/gridView.svg',
                      width: 15,
                      height: 15,
                    )
                        : SvgPicture.asset(
                      'assets/icons/listView.svg',
                      width: 15,
                      height: 15,
                    ),
                  ),
                ],
              ),
            ),
            wallpapers.isEmpty
                ? Center(child: Text('Nothing here'))
                : Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(47.0, 12.0, 47.0, 0.0),
                child: wallpapers.isEmpty
                    ? Center(child: Text('Nothing here'))
                    : isGrid
                    ? homepageCard(wallpapers, context)
                    : listView(wallpapers),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
