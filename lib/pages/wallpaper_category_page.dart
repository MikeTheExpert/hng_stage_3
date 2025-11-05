import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hng_stage_3/design_widgets/fav_card_widget.dart';
import 'package:hng_stage_3/design_widgets/list_view.dart';
import '../design_widgets/nav_bar_widget.dart';
import '../models/helper_class.dart';
import '../models/wallpaper_model.dart';


class WallpapersCategoryPage extends StatefulWidget {
  final String category;
  final List wallpapers;

  const WallpapersCategoryPage({
    super.key,
    required this.category,
    required this.wallpapers,
  });

  @override
  State<WallpapersCategoryPage> createState() => _WallpapersCategoryPageState();
}

class _WallpapersCategoryPageState extends State<WallpapersCategoryPage> {
  final db = DatabaseHelper();
  List<Wallpaper> wallpapers = [];
  bool isGrid = true;
  
  @override
  void initState() {
    super.initState();
  }
  toggleDisplayView() {
    setState(() {
      isGrid =!isGrid;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Filter wallpapers by category
    final filtered = widget.wallpapers.where((w) => w.category == widget.category).toList();

    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          Row(
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
          filtered.isEmpty
              ? const Center(child: Text("No wallpapers in this category"))
              : isGrid? favInfoCard(wallpapers, context): listView(wallpapers)
        ],
      ),
    );
  }
}
