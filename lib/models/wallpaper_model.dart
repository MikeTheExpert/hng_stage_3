class Wallpaper {
  final int? id;
  final String title;
  final String description;
  final String moodSet;
  final String filePath;
  final String category;
  final bool isFavorite;

  Wallpaper({
    this.id,
    required this.title,
    required this.description,
    required this. moodSet,
    required this.filePath,
    required this.category,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'moodSet': moodSet,
      'filePath': filePath,
      'category': category,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Wallpaper.fromMap(Map<String, dynamic> map) {
    return Wallpaper(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      moodSet: map['moodSet'],
      filePath: map['filePath'],
      category: map['category'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
