import 'dart:io';
import 'package:flutter/material.dart';

import '../pages/wallpaper_category_page.dart';

Widget listView(wallpapers, onTap){
  return ListView.builder(
    itemCount: wallpapers.length,
    itemBuilder: (context, index) {
      final wallpaperItem = wallpapers[index];
      return GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WallpapersCategoryPage(
                category: wallpaperItem.category,
                wallpapers: wallpapers, // pass your full list here
              ),
            ),
          );
        },
        child: ListTile(
          leading: Image.file(
            File(wallpaperItem.filePath),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(wallpaperItem.title),
          subtitle: Text(wallpaperItem.category),
        ),
      );
    },
  );
}