import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hng_stage_3/models/wallpaper_model.dart';

class ActiveWallpaperCard extends StatelessWidget {
  final Wallpaper? wallpaper;

  const ActiveWallpaperCard({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const Text(
              "Your Active Wallpaper",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "This wallpaper is currently set as your active background",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 12),

            /// Wallpaper Preview
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(wallpaper!.filePath),
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 12),

            /// Category & Selection
            Text(
              "Category - ${wallpaper?.category}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              "Selection - ${wallpaper?.title ?? "Untitled"}",
              style: const TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 16),

            /// Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    // download logic
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // share logic
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
