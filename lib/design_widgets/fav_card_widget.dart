import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/favourite_btn.dart';

Widget infoCard(wallpapers, context) {
  return GridView.builder(
    gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 435,
      mainAxisExtent: 290,
      crossAxisSpacing: 23,
      mainAxisSpacing: 20,
    ),
    itemCount: wallpapers.length,
    itemBuilder: (BuildContext context, int index) {
      final cardItem = wallpapers[index];
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(cardItem.filePath)), // FileImage
            fit: BoxFit.cover, // cover, contain, fill, etc.
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: FavouriteButton(wallpaper: wallpapers),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: textDisplay(cardItem.title, cardItem.category),
            ),
          ],
        ),
      );
    },
  );
}

//at width 440 the navbar should turn into a drawer

Widget textDisplay(titleData,categoryData) {
  return Column(
    children: [
      Text(
        titleData,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
      ),

      Card(
        color: Color.fromRGBO(255, 255, 255, 0.2),
        child: Text(
          categoryData,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
