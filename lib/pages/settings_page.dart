import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/nav_bar_widget.dart';
import '../models/save_settings_helper_class.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MySettings();
  }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NavBar(),
              const SizedBox(height: 20),
              const Text("Settings", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Image Quality', style: TextStyle(fontSize: 18)),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Allow Notifications', style: TextStyle(fontSize: 18)),
                            Switch(
                              value: allowNotifications,
                              onChanged: (bool value) {
                                setState(() {
                                  allowNotifications = value;
                                });
                              },
                              activeColor: const Color.fromRGBO(251, 176, 59, 1),
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
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Container(
                    width: 249,
                    height: 520,
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
                        Container(
                          width: 60,
                          height: 60,
                          color: Colors.green,
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          color: Colors.green,
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          color: Colors.green,
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
