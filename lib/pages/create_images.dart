import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _saveWallpaper() async {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      final wallpaper = Wallpaper(
        title: _titleController.text,
        description: _descriptionController.text,
        moodSet: _moodSetController.text,
        filePath: _selectedImage!.path,
        category: _categoryController.text,
      );

      // Call your DB helper insert function
      final id = await DatabaseHelper.instance.insertWallpaper(wallpaper);
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper saved with id: $id')),
      );

      Navigator.pop(context, true); // return true to refresh parent
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select an image')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Wallpaper")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a title" : null,
                ),
                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a description" : null,
                ),
                // MoodSet
                TextFormField(
                  controller: _moodSetController,
                  decoration: const InputDecoration(labelText: "Mood Set"),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a mood set" : null,
                ),
                // Category
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(labelText: "Category"),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a category" : null,
                ),
                const SizedBox(height: 16),

                // Image Picker
                _selectedImage != null
                    ? Image.file(_selectedImage!, height: 150, fit: BoxFit.cover)
                    : const Text("No image selected"),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Pick Image"),
                ),

                const SizedBox(height: 20),

                // Save Button
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
