import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hng_stage_3/design_widgets/nav_bar_widget.dart';
import 'package:hng_stage_3/models/wallpaper_model.dart';
import 'package:hng_stage_3/design_widgets/list_view.dart';

import '../design_widgets/fav_card_widget.dart';
import '../models/helper_class.dart'; // list widget

class SimilarCategoryPage extends StatefulWidget {
  final String category;
  final int? excludeId; // optional: exclude the current wallpaper

  const SimilarCategoryPage({
    super.key,
    required this.category,
    this.excludeId,
  });

  @override
  State<SimilarCategoryPage> createState() => _SimilarCategoryPageState();
}

class _SimilarCategoryPageState extends State<SimilarCategoryPage> {
  final db = DatabaseHelper();
  List<Wallpaper> wallpapers = [];
  bool isGrid = true;
  Wallpaper? selectedWallpaper;

  @override
  void initState() {
    super.initState();
    _loadWallpapers();

  }

  Future<void> _loadWallpapers() async {
    final data = await db.getWallpapersByCategory(
      widget.category,
      excludeId: widget.excludeId,
    );
    setState(() {
      wallpapers = data;
    });
  }

  void _toggleView() {
    setState(() {
      isGrid = !isGrid;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(child: NavBar()),
            Align(
              alignment: Alignment.centerRight,
              child:
              IconButton(
                onPressed: _toggleView,
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
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            wallpapers.isEmpty
                ? const Center(child: Text("No favourites yet ⭐"))
                : Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(47.0, 12.0, 47.0, 0.0),
                child: infoCard(wallpapers, context),
              ),
            ),

            ],
            ),
          ],
        ),

        /// Right side: preview card (only if selected)
      ),
    );
  }

}
