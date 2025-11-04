class SettingsModel {
  final String? imageQuality;
  final bool allowNotifications;
  final bool activated;
  final String? displayMode;
  final bool autoRotation;
  final bool lockWallpaper;
  final bool syncAcrossDevices;

  SettingsModel({
     this.imageQuality,
    this.allowNotifications = false,
    this.activated = false,
    this.displayMode,
    this.autoRotation = false,
    this.lockWallpaper = false,
    this.syncAcrossDevices = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageQuality': imageQuality,
      'allowNotifications': allowNotifications ? 1 : 0,
      'activated': activated ? 1 : 0,
      'displayMode': displayMode,
      'autoRotation': autoRotation ? 1 : 0,
      'lockWallpaper': lockWallpaper ? 1 : 0,
      'syncAcrossDevices': syncAcrossDevices ? 1 : 0,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      imageQuality: map['imageQuality'],
      allowNotifications: map['allowNotifications'] == 1,
      activated: map['activated'] == 1,
      displayMode: map['displayMode'],
      autoRotation: map['autoRotation'] == 1,
      lockWallpaper: map['lockWallpaper'] == 1,
      syncAcrossDevices: map['syncAcrossDevices'] == 1,
    );
  }
}
