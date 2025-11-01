import 'package:flutter/material.dart';
import 'package:hng_stage_3/models/wallpaper_model.dart';
import 'package:hng_stage_3/models/helper_class.dart';

class FavouriteButton extends StatefulWidget {
  final Wallpaper wallpaper;

  const FavouriteButton({super.key, required this.wallpaper});

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  final db = DatabaseHelper();
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = widget.wallpaper.isFavorite;
  }

  Future<void> _toggleFavourite() async {
    setState(() {
      isFav = !isFav;
    });

    // Update in database
    await db.toggleFavorite(widget.wallpaper.id!, isFav);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite_border_outlined: Icons.favorite_border,
        color: isFav ? Colors.amber : Colors.transparent,
      ),
      onPressed: _toggleFavourite,
    );
  }
}
