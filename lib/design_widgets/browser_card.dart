import 'dart:io';
import 'package:flutter/material.dart';

import '../pages/similar_category.dart';
import '../pages/wallpaper_category_page.dart';
import 'favourite_btn.dart';

Widget browserPageCard(List wallpapers, BuildContext context) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 400,   // each tile max width → controls how many per row
      mainAxisExtent: 250,       // fixed height for each tile
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    ),
    itemCount: wallpapers.length,
    itemBuilder: (BuildContext context, int index) {
      final cardItem = wallpapers[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WallpapersCategoryPage(
                category: cardItem.category,
                wallpapers: wallpapers,// pass the current wallpaper's category
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(
                File(cardItem.filePath),
                fit: BoxFit.cover, // ensures full coverage
              ), Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FavouriteButton(wallpaper: cardItem),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black54,
                  child: textDisplay(cardItem.category, cardItem.moodSet),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget textDisplay(String categoryData, String moodSetData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        categoryData,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        moodSetData,
        style: const TextStyle(
          color: Colors.white70,
          fontFamily: 'Poppins',
          fontSize: 12,
        ),
      ),
    ],
  );
}
