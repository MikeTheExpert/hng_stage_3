import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/favourite_btn.dart';

Widget infoCard(wallpaper, imageFile, textData) {
  return Container(
    width: 435.3333435058594,
    height: 290.711669921875,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imageFile), // or NetworkImage / FileImage
        fit: BoxFit.cover, // cover, contain, fill, etc.
      ),
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(26),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: FavouriteButton(wallpaper: wallpaper),
        ),
        textDisplay(textData),
      ],
    ),
  );
}

//at width 440 the navbar should turn into a drawer

Widget textDisplay(textData) {
  return Positioned(
    child: Column(
      children: [
        Text(textData),
        OutlinedButton(onPressed: onPressed, child: Text(textData)),
      ],
    ),
  );
}
