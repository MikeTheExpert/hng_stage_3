
import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/fav_card_widget.dart';
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
  void toggleDisplayView(){
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
          wallpapers.isEmpty
              ? const Center(child: Text("No favourites yet ⭐"))
              : Expanded(child: Padding(
                padding: const EdgeInsets.fromLTRB(47.0, 12.0, 47.0, 0.0),
                child: infoCard(wallpapers, context),
              )),
        ],
      )
    );
  }
}
