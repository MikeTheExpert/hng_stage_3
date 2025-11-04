import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text("Similar: ${widget.category}"),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: _toggleView,
          ),
        ],
      ),
      body: Column(
        children: [
          NavBar(),
          wallpapers.isEmpty
              ? const Center(child: Text("No similar wallpapers found"))
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: isGrid
                ? infoCard(wallpapers, context) // your grid widget
                : listView(wallpapers), // your list widget
          ),
        ],
      ),
    );
  }
}
