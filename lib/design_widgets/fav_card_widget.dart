import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hng_stage_3/pages/home_page.dart';
import 'package:path/path.dart';

import '../models/wallpaper_model.dart';
import 'favourite_btn.dart';

Widget infoCard(
    List<Wallpaper> wallpapers,
    BuildContext context, ) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 190,
      mainAxisExtent: 290,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    ),
    itemCount: wallpapers.length,
    itemBuilder: (BuildContext context, int index) {
      final cardItem = wallpapers[index];
      return GestureDetector(
        onTap : (){},
        // onTap: () => onWallpaperTap(cardItem, context), // 🔥 call the callback
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(File(cardItem.filePath), fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FavouriteButton(wallpaper: cardItem),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: textDisplay(cardItem.category, cardItem.title),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget onWallpaperTap(Wallpaper cardItem, context) {
  return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallpaper preview
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                cardItem.filePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              cardItem.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Tags
            Wrap(
              spacing: 8,
              children: cardItem.moodSet.split(',')
                  .map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.grey.shade200,
              ))
                  .toList(),
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              cardItem.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),

            const SizedBox(height: 20),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: (){},
                  child: const Text("Save to Favorites"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onPressed: (){Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>MyHomePage()),);},
                  child: const Text("Set to Wallpaper"),
                ),
              ],
            ),
          ],
        ),
      ),
  );
}


Widget favInfoCard(List wallpapers, BuildContext context) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 190,
      mainAxisExtent: 290,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    ),
    itemCount: wallpapers.length,
    itemBuilder: (BuildContext context, int index) {
      final cardItem = wallpapers[index];
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(File(cardItem.filePath), fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FavouriteButton(wallpaper: cardItem),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: textDisplay(cardItem.category, cardItem.title),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget textDisplay(String categoryData, String titleData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        titleData,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      Container(
        width: 72,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color.fromRGBO(255, 255, 255, 0.2),
        ),
        child: Text(
          categoryData,
          style: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}
