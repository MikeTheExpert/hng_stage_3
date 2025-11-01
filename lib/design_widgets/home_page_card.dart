
import 'dart:io';

import 'package:flutter/material.dart';


Widget homepageCard (wallpapers, context, ){
  final screenWidth = MediaQuery.of(context).size.width;
  final itemWidth = 150.0; // desired width per item
  final crossAxisCount = (screenWidth / itemWidth).floor();

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.5,
    ),
    itemCount: wallpapers.length,
    itemBuilder: (BuildContext context, int index) {
      final cardItem = wallpapers[index];
      return Container(
        width: 435.3333435058594,
        height: 290.711669921875,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(cardItem.filePath)), // FileImage
            fit: BoxFit.cover, // cover, contain, fill, etc.
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: textDisplay(cardItem.category, cardItem.moodSet),
        );
    },
  );
}

//at width 440 the navbar should turn into a drawer

Widget textDisplay(textData, categoryData) {
  return Positioned(
    child: Column(
      children: [
        Text(textData),
        Card(color: Color.fromRGBO(254,254,254,1),child: Text(categoryData),),
      ],
    ),
  );
}