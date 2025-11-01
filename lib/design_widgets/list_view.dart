import 'dart:io';
import 'package:flutter/material.dart';

Widget listView(wallpapers){
  return ListView.builder(
    itemCount: wallpapers.length,
    itemBuilder: (context, index) {
      final wallpaperItem = wallpapers[index];
      return ListTile(
        leading: Image.file(
          File(wallpaperItem.filePath),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(wallpaperItem.title),
        subtitle: Text(wallpaperItem.category),
      );
    },
  );
}