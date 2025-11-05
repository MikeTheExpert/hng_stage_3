import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/fav_card_widget.dart';
import 'package:hng_stage_3/design_widgets/empty_favourite_widget.dart';
import 'package:hng_stage_3/models/wallpaper_model.dart';

import '../design_widgets/nav_bar_widget.dart';
import '../models/helper_class.dart';

class MyFavourite extends StatefulWidget {
  const MyFavourite({super.key});

  @override
  State<MyFavourite> createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  final db = DatabaseHelper();
  List<Wallpaper> wallpapers = [];
  bool isGrid = false;

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final data = await db.getFavourites();
    setState(() {
      wallpapers = data;
    });
  }

  void toggleDisplayView() {
    setState(() {
      isGrid != isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          Padding(
            padding: const EdgeInsets.fromLTRB(48.0, 30.0, 48.0, 8.0),
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
                  'SavedWallpapers',
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
                'Your saved wallpapers collection',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          wallpapers.isEmpty
              ? EmptySavedWallpapers(
                onBrowseTap:
                    () => Navigator.pushReplacementNamed(context, '/browse'),
              )
              : Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(47.0, 12.0, 47.0, 0.0),
                  child: favInfoCard(wallpapers, context),
                ),
              ),
        ],
      ),
    );
  }
}
