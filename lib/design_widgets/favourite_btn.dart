import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/helper_class.dart';
import '../models/wallpaper_model.dart';

class FavouriteButton extends StatefulWidget {
  final Wallpaper wallpaper;

  const FavouriteButton({super.key, required this.wallpaper});

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  final db = DatabaseHelper();
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _loadFavouriteStatus();
  }

  Future<void> _loadFavouriteStatus() async {
    if (widget.wallpaper.id != null) {
      final favStatus = await db.isFavorite(widget.wallpaper.id!);
      setState(() {
        isFav = favStatus;
      });
    }
  }

  Future<void> _toggleFavourite() async {
    if (widget.wallpaper.id == null) {
      // Can't toggle if the wallpaper hasn't been inserted yet
      return;
    }

    setState(() {
      isFav = !isFav;
    });

    await db.toggleFavorite(widget.wallpaper.id!, isFav);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavourite,
      icon: CircleAvatar(
        radius: 20,
        backgroundColor: isFav ? Colors.white : Colors.transparent,
        child: SvgPicture.asset(
          isFav ? 'assets/icons/selectedFavBtn.svg' : 'assets/icons/favBtn.svg',
          width: 16,
          height: 16,
          color: isFav ? Colors.amberAccent : Colors.grey,
        ),
      ),
    );
  }
}
