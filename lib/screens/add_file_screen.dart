import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mediscanai/models/medical_files.dart';
import 'package:mediscanai/screens/NearbyMedicalsMapScreen.dart'; // Ensure this path is correct

class AddFileScreen extends StatefulWidget {
  final Function(MedicalFile) onFileSaved;

  const AddFileScreen({super.key, required this.onFileSaved});

  @override
  State<AddFileScreen> createState() => _AddFileScreenState();
}

class _AddFileScreenState extends State<AddFileScreen> {
  File? _selectedFile;
  TextEditingController _nameController = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      _selectedFile = File(result.files.single.path!);
      _nameController.text = result.files.single.name;
      setState(() {});
    }
  }

  Future<void> _saveFile() async {
    // Check if the file is selected and name is provided/not empty
    if (_selectedFile == null || _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a file and enter a valid name."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final dir = await getApplicationDocumentsDirectory();
      // Use path_provider's path, and ensure the filename is safe (e.g., removing leading/trailing spaces)
      final fileName = _nameController.text.trim();
      final newFile = await _selectedFile!.copy('${dir.path}/$fileName');

      final medicalFile = MedicalFile(
        path: newFile.path,
        name: fileName,
        date: DateTime.now(),
      );

      widget.onFileSaved(medicalFile);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving file: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Medical File"),
        backgroundColor: Colors.teal, // Teal AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Pick File Button ---
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.attach_file),
              label: const Text("Pick a File"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Teal button
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 15),

            // --- Find Nearby Medicals Button (MOVED HERE) ---
            // This button is now visible whether a file is selected or not.
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NearbyMedicalsMapScreen()),
                );
              },
              icon: const Icon(Icons.map),
              label: const Text("Find Nearby Medicals"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade400, // Slightly lighter teal for distinction
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),

            if (_selectedFile != null) ...[
              const Text(
                "File Details:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(height: 15),

              // --- File Preview ---
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal.shade300, width: 2),
                ),
                alignment: Alignment.center,
                child: _previewWidget(),
              ),

              const SizedBox(height: 20),

              // --- File Name Input ---
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "File Name",
                  labelStyle: const TextStyle(color: Colors.teal),
                  prefixIcon: const Icon(Icons.drive_file_rename_outline, color: Colors.teal),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- Save Button ---
              ElevatedButton.icon(
                onPressed: _saveFile,
                icon: const Icon(Icons.save),
                label: const Text("Save File"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700, // Darker Teal for primary action
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ] else
              Center(
                child: Column(
                  children: [
                    Icon(Icons.cloud_upload, size: 80, color: Colors.teal.shade300),
                    const SizedBox(height: 10),
                    const Text("Select a file to begin", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _previewWidget() {
    final ext = _selectedFile!.path.split('.').last.toLowerCase();

    const Color iconColor = Colors.teal;

    if (['png', 'jpg', 'jpeg'].contains(ext)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(_selectedFile!, fit: BoxFit.cover, width: double.infinity),
      );
    } else if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
      return const Icon(Icons.videocam, size: 80, color: iconColor);
    } else if (['pdf'].contains(ext)) {
      return const Icon(Icons.picture_as_pdf, size: 80, color: iconColor);
    } else if (['doc', 'docx'].contains(ext)) {
      return const Icon(Icons.description, size: 80, color: iconColor);
    } else {
      return const Icon(Icons.insert_drive_file, size: 80, color: iconColor);
    }
  }
}