import 'dart:io';

import 'package:flutter/material.dart';

Widget homepageCard(wallpapers, context) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
            image: FileImage(File(cardItem.filePath)),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: textDisplay(cardItem.category, cardItem.moodSet),
        ),
      );
    },
  );
}

//at width 440 the navbar should turn into a drawer

Widget textDisplay(categoryData,moodSetData) {
  return Column(
    children: [
      Text(
        categoryData,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        moodSetData,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      Card(
        color: Color.fromRGBO(255, 255, 255, 0.2),
        child: Text(moodSetData),
      ),
    ],
  );
}
