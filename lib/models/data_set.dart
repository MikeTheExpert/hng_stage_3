
import 'package:hng_stage_3/models/wallpaper_model.dart';

final List<Wallpaper> sampleWallpapers = [
  Wallpaper(
    id: 1,
    title: "Sunset Bliss",
    description: "A calming sunset over the ocean horizon.",
    moodSet: "Relaxing",
    filePath: "assets/images/sunset.jpg", // use an asset or placeholder path
    category: "Nature",
    isFavorite: true,
  ),
  Wallpaper(
    id: 2,
    title: "City Lights",
    description: "Night view of a bustling city skyline.",
    moodSet: "Energetic",
    filePath: "assets/images/city.jpg",
    category: "Urban",
  ),
  Wallpaper(
    id: 3,
    title: "Mountain Escape",
    description: "Snowy peaks under a clear blue sky.",
    moodSet: "Peaceful",
    filePath: "assets/images/mountain.jpg",
    category: "Adventure",
  ),
  Wallpaper(
    id: 4,
    title: "Abstract Colors",
    description: "A vibrant splash of abstract art.",
    moodSet: "Creative",
    filePath: "assets/images/abstract.png",
    category: "Art",
  ),
];
