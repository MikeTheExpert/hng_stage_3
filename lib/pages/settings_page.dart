import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/nav_bar_widget.dart';
import '../models/save_settings_helper_class.dart';

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
            /// NavBar stays at the top
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: NavBar(),
            ),

            const SizedBox(height: 20),

            /// Page title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Settings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            /// Main content expands to fill remaining space
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Left side: settings form
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Image Quality',
                              style: TextStyle(fontSize: 18)),
                          DropdownButton<String>(
                            value: selectedQuality,
                            hint: const Text('Select Quality'),
                            items: qualityOptions.map((String value) {
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Allow Notifications',
                                  style: TextStyle(fontSize: 18)),
                              Switch(
                                value: allowNotifications,
                                onChanged: (bool value) {
                                  setState(() {
                                    allowNotifications = value;
                                  });
                                },
                                activeColor:
                                const Color.fromRGBO(251, 176, 59, 1),
                                inactiveThumbColor: Colors.grey,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  // Save logic can be added here
                                },
                                child: const Text('Save Settings'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Right side: preview container
                  Container(
                    width: 249,
                    height: 520,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 3.31,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(width: 60, height: 60, color: Colors.green),
                        Container(width: 60, height: 60, color: Colors.green),
                        Container(width: 60, height: 60, color: Colors.green),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.shade400,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
