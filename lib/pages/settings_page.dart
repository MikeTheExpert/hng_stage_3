import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/nav_bar_widget.dart';
import '../models/save_settings_helper_class.dart';
import '../models/settings_model.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<StatefulWidget> createState() => _MySettings();
}

class _MySettings extends State<MySettings> {
  final db = SettingsDatabaseHelper();

  String? selectedQuality;
  bool allowNotifications = false;

  final List<String> qualityOptions = ['Low', 'Medium', 'High'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await db.getSettings();
    if (settings != null) {
      setState(() {
        selectedQuality = settings.imageQuality;
        allowNotifications = settings.allowNotifications;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// NavBar
            const Padding(padding: EdgeInsets.all(8.0), child: NavBar()),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 30.0, 48.0, 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ShaderMask(
                  shaderCallback:
                      (bounds) => const LinearGradient(
                        colors: [
                          Color.fromRGBO(251, 176, 59, 1),
                          Color.fromRGBO(236, 12, 67, 1),
                        ], // your two colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: const Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'ClashDisplay',
                      fontSize: 60,
                      color: Colors.white, // must be white to show gradient
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(47.0, 0.0, 47.0, 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Customize your Wallpaper Studio experience',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Unified container
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Left side: settings widgets
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            /// Dropdown in bordered box
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Image Quality',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  DropdownButton<String>(
                                    value: selectedQuality,
                                    hint: const Text('Select Quality'),
                                    isExpanded: true,
                                    underline:
                                        const SizedBox(), // remove default underline
                                    items:
                                        qualityOptions.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedQuality = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),

                            /// Switch in bordered box
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Allow Notifications',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Switch(
                                    value: allowNotifications,
                                    onChanged: (bool value) {
                                      setState(() {
                                        allowNotifications = value;
                                      });
                                    },
                                    activeColor: const Color.fromRGBO(
                                      251,
                                      176,
                                      59,
                                      1,
                                    ),
                                    inactiveThumbColor: Colors.grey,
                                  ),
                                ],
                              ),
                            ),

                            /// Buttons aligned to end
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Card(
                                  color: Color.fromRGBO(248, 248, 248, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ), // 👈 sets the border radius
                                  ),

                                  child: OutlinedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Card(
                                  color: Color.fromRGBO(251, 176, 59, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ),),
                                    child: OutlinedButton(
                                    onPressed: () async {
                                      final settings = SettingsModel(
                                        imageQuality:
                                            selectedQuality ?? 'Medium',
                                        allowNotifications: allowNotifications,
                                      );

                                      await db.saveSettings(settings);
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Settings saved!',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('Save Settings'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      /// Right side: fixed-size phone preview
                      Container(
                        width: 322,
                        height: 636,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/phone.jpg',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
