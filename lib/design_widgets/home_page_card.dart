import 'dart:io';
import 'package:flutter/material.dart';

Widget homepageCard(List wallpapers, BuildContext context) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 250,   // each tile max width → controls how many per row
      mainAxisExtent: 250,       // fixed height for each tile
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
            Image.file(
              File(cardItem.filePath),
              fit: BoxFit.cover, // ensures full coverage
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
