import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/list_view.dart';
import 'package:hng_stage_3/design_widgets/home_page_card.dart';
import 'package:hng_stage_3/design_widgets/nav_bar_widget.dart';

import '../models/helper_class.dart';
import '../models/wallpaper_model.dart';
import 'create_images.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateWallpaperPage(),
            ),
          );
          if (result == true) {
            // Refresh your wallpapers list after insertion
            setState(() {});
          }
        },
        icon: Icon(Icons.add_outlined),
      ),
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
                    'Discover Beautiful Wallpapers',
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
              padding: const EdgeInsets.fromLTRB(47.0, 0.0, 47.0, 50.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Discover curated collections of stunning wallpapers. Browse by category, preview in full-screen, and set your favorites.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(47.0, 0.0, 47.0, 33.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',

                    ),
                  ),
                  TextButton(onPressed: () => Navigator.pushReplacementNamed(context,'/browse'),
                  child: Text("See More",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),)),
                ],
              ),
            ),
            wallpapers.isEmpty
                ? Center(child: Text('Nothing here'))
                : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(47.0, 0.0, 0.0, 47.0),
                    child:
                        wallpapers.isEmpty
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
