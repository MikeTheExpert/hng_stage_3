import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptySavedWallpapers extends StatelessWidget {
  final VoidCallback onBrowseTap;

  const EmptySavedWallpapers({
    super.key,
    required this.onBrowseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration placeholder
            SvgPicture.asset(
              'assets/icons/Group 3.svg',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 24),

            // Title
            const Text(
              "No Saved Wallpapers",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              "Start saving your favorite wallpapers to see them here",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Browse button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onBrowseTap,
              child: const Text(
                "Browse Wallpapers",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
