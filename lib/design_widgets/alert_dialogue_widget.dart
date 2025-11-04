import 'package:flutter/material.dart';

import '../models/save_settings_helper_class.dart';
import '../models/settings_model.dart';

class WallpaperSetupPage extends StatefulWidget {
  const WallpaperSetupPage({super.key});

  @override
  State<WallpaperSetupPage> createState() => _WallpaperSetupPageState();
}

class _WallpaperSetupPageState extends State<WallpaperSetupPage> {
  bool activated = true;
  String displayMode = "Fit";
  bool autoRotation = false;
  bool lockWallpaper = false;
  bool syncAcrossDevices = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final saved = await SettingsDatabaseHelper.instance.getSettings();
    if (saved != null) {
      setState(() {
        activated = saved.activated;
        displayMode = saved.displayMode!;
        autoRotation = saved.autoRotation;
        lockWallpaper = saved.lockWallpaper;
        syncAcrossDevices = saved.syncAcrossDevices;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Wallpaper Setup"),
            /// Subtitle
            const Text(
              "Configure your wallpaper settings and enable auto-rotation.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            /// Activate Wallpaper
            _buildCard(
              title: "Activate Wallpaper",
              description: "Set the selected wallpaper as your desktop background.",
              trailing: Switch(
                value: activated,
                onChanged: (val) => setState(() => activated = val),
                activeColor: Colors.orange,
              ),
            ),

            const SizedBox(height: 20),

            /// Display Mode
            _buildCard(
              title: "Display Mode",
              description: "Choose how the wallpaper is displayed.",
              child: Column(
                children: [
                  _buildRadio("Fit", "Scale to fit without cropping"),
                  _buildRadio("Fill", "Scale to fill the entire screen"),
                  _buildRadio("Stretch", "Stretch to fill the screen"),
                  _buildRadio("Tile", "Repeat the image to fill the screen"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Auto-Rotation
            _buildCard(
              title: "Auto-Rotation",
              description: "Automatically change your wallpaper at regular intervals.",
              trailing: Switch(
                value: autoRotation,
                onChanged: (val) => setState(() => autoRotation = val),
                activeColor: Colors.orange,
              ),
            ),

            const SizedBox(height: 20),

            /// Advanced Settings
            _buildCard(
              title: "Advanced Settings",
              description: "Additional options for wallpaper control.",
              child: Column(
                children: [
                  CheckboxListTile(
                    value: lockWallpaper,
                    onChanged: (val) => setState(() => lockWallpaper = val!),
                    title: const Text("Lock Wallpaper"),
                    subtitle: const Text("Prevent accidental changes"),
                    activeColor: Colors.orange,
                  ),
                  CheckboxListTile(
                    value: syncAcrossDevices,
                    onChanged: (val) => setState(() => syncAcrossDevices = val!),
                    title: const Text("Sync Across Devices"),
                    subtitle: const Text("Keep wallpaper consistent on all devices"),
                    activeColor: Colors.orange,
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final settings = SettingsModel(
                      activated: activated,
                      displayMode: displayMode,
                      autoRotation: autoRotation,
                      lockWallpaper: lockWallpaper,
                      syncAcrossDevices: syncAcrossDevices,
                    );

                    await SettingsDatabaseHelper.instance.saveSettings(settings);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Settings saved!")),
                    );
                  },
                  child: const Text("Save Settings"),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper for cards
  Widget _buildCard({
    required String title,
    required String description,
    Widget? trailing,
    Widget? child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(color: Colors.black54)),
          if (child != null) ...[
            const SizedBox(height: 12),
            child,
          ],
        ],
      ),
    );
  }

  /// Helper for radio options
  Widget _buildRadio(String value, String subtitle) {
    return RadioListTile<String>(
      value: value,
      groupValue: displayMode,
      onChanged: (val) => setState(() => displayMode = val!),
      title: Text(value),
      subtitle: Text(subtitle),
      activeColor: Colors.orange,
    );
  }
}