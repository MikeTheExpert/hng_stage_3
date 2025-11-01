import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hng_stage_3/models/wallpaper_model.dart';

import '../models/helper_class.dart';

class MyFavourite extends StatefulWidget {
  const MyFavourite({super.key});

  @override
  State<MyFavourite> createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  final db = DatabaseHelper();
  List<Wallpaper> wallpapers = [];

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final data = await db.getFavourites();
    setState(() {
      wallpapers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Favourites")),
      body: wallpapers.isEmpty
          ? const Center(child: Text("No favourites yet ⭐"))
          : ListView.builder(
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
            trailing: const Icon(Icons.star, color: Colors.amber),
          );
        },
      ),
    );
  }
}
