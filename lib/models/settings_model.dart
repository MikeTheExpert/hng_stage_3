class SettingsModel{
  final String imageQuality;
  final bool allowNotifications;

  SettingsModel({
    required this.imageQuality,
    this.allowNotifications = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageQuality': imageQuality,
      'allowNotifications': allowNotifications ? 1 : 0,
    };
  }
    factory SettingsModel.fromMap(Map<String, dynamic> map) {
      return SettingsModel(
        imageQuality: map['imageQuality'],
        allowNotifications: map['allowNotifications'] == 1,
      );
  }
}