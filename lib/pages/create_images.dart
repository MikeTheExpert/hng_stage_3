import 'dart:typed_data';
import 'dart:io' show File; // only available on non-web
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../design_widgets/nav_bar_widget.dart';
import '../models/helper_class.dart';
import '../models/wallpaper_model.dart';

class CreateWallpaperPage extends StatefulWidget {
  const CreateWallpaperPage({super.key});

  @override
  CreateWallpaperPageState createState() => CreateWallpaperPageState();
}

class CreateWallpaperPageState extends State<CreateWallpaperPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _moodSetController = TextEditingController();
  final _categoryController = TextEditingController();

  File? _selectedImageFile;       // for desktop/mobile
  Uint8List? _selectedImageBytes; // for web

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _selectedImageBytes = bytes;
        });
      } else {
        setState(() {
          _selectedImageFile = File(pickedFile.path);
        });
      }
    }
  }

  void _saveWallpaper() async {
    final hasImage = kIsWeb ? _selectedImageBytes != null : _selectedImageFile != null;

    if (_formKey.currentState!.validate() && hasImage) {
      final wallpaper = Wallpaper(
        title: _titleController.text,
        description: _descriptionController.text,
        moodSet: _moodSetController.text,
        // on web you can’t rely on a file path, so store empty string or handle differently
        filePath: kIsWeb ? '' : _selectedImageFile!.path,
        category: _categoryController.text,
      );

      final id = await DatabaseHelper.instance.insertWallpaper(wallpaper);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper saved with id: $id')),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (kIsWeb && _selectedImageBytes != null) {
      imageWidget = Image.memory(_selectedImageBytes!, height: 150, fit: BoxFit.cover);
    } else if (!kIsWeb && _selectedImageFile != null) {
      imageWidget = Image.file(_selectedImageFile!, height: 150, fit: BoxFit.cover);
    } else {
      imageWidget = const Text("No image selected");
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Flexible(child: NavBar(),),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a title" : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a description" : null,
                ),
                TextFormField(
                  controller: _moodSetController,
                  decoration: const InputDecoration(labelText: "Mood Set"),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a mood set" : null,
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(labelText: "Category"),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a category" : null,
                ),
                const SizedBox(height: 16),

                imageWidget,
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Pick Image"),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _saveWallpaper,
                  child: const Text("Save Wallpaper"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
