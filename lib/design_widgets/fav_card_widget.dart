import 'dart:io';
import 'package:flutter/material.dart';

import 'favourite_btn.dart';

Widget infoCard(List wallpapers, BuildContext context) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 190,   // each tile max width → controls how many per row
      mainAxisExtent: 290,       // fixed height for each tile
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
      color: Color.fromRGBO(255, 255, 255, 0.2),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
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




