import 'dart:io';
import 'package:flutter/material.dart';
import '../models/wallpaper_model.dart';


class WallpapersCategoryPage extends StatelessWidget {
  final String category;
  final List<Wallpaper> wallpapers;

  const WallpapersCategoryPage({
    super.key,
    required this.category,
    required this.wallpapers,
  });

  @override
  Widget build(BuildContext context) {
    // Filter wallpapers by category
    final filtered = wallpapers.where((w) => w.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Category: $category"),
      ),
      body: filtered.isEmpty
          ? const Center(child: Text("No wallpapers in this category"))
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final wallpaper = filtered[index];
          return GestureDetector(
            onTap: () {
              // You could navigate deeper if needed
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: FileImage(File(wallpaper.filePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
