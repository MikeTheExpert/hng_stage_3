import 'dart:io';
import 'package:flutter/material.dart';

Widget listView(wallpapers){
  return ListView.builder(
    itemCount: wallpapers.length,
    itemBuilder: (context, index) {
      final wallpaperItem = wallpapers[index];
      return SizedBox(
        width: 1365,
        height:100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),),
          child: ListTile(
            leading: Image.file(
              File(wallpaperItem.filePath),
              fit: BoxFit.cover,
            ),
            title: Text(wallpaperItem.title, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
            subtitle: Text(wallpaperItem.category,style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400),),
          ),
        ),
      );
    },
  );
}
Widget categoryListView(wallpapers, {required Null Function(dynamic wallpaper) onWallpaperTap}){
  return ListView.builder(
    itemCount: wallpapers.length,
    itemBuilder: (context, index) {
      final wallpaperItem = wallpapers[index];
      return GestureDetector(
        onTap: ()=>onWallpaperTap(wallpaperItem),
          child:SizedBox(
            width: double.infinity,
            height: 225,
            child: ListTile(
                    leading: Image.file(
            File(wallpaperItem.filePath),
            width: 227,
            height: 185,
            fit: BoxFit.cover,
                    ),
                    title: Text(wallpaperItem.title, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
                    subtitle: Text(wallpaperItem.category,style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400),),
                  ),
          ));
    },
  );
}