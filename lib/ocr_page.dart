import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  File? _image;
  String _extractedText = "No text found yet";
  bool _isProcessing = false; // Added for a loading indicator

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _extractedText = "Processing image...";
        _isProcessing = true;
      });
      _recognizeText(_image!);
    }
  }

  Future<void> _recognizeText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      setState(() {
        _extractedText = recognizedText.text.isNotEmpty
            ? recognizedText.text
            : "No text found yet";
      });
    } catch (e) {
      setState(() {
        _extractedText = "Error during recognition.";
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
      textRecognizer.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prescription OCR"), // Title kept the same
        backgroundColor: Colors.teal, // Teal AppBar color
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView for better UI handling
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Image Preview Section ---
            const Text(
              "Image Preview:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 15),

            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal.shade300, width: 2),
              ),
              alignment: Alignment.center,
              child: _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.file(_image!, fit: BoxFit.cover, height: 250, width: double.infinity),
              )
                  : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_camera_front, size: 50, color: Colors.teal),
                  SizedBox(height: 8),
                  Text("No image selected", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Divider(color: Colors.teal.shade200),
            const SizedBox(height: 30),

            // --- Button Section ---
            ElevatedButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text("Capture from Camera"), // Text kept the same
              onPressed: () => _pickImage(ImageSource.camera),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Teal button color
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text("Pick from Gallery"), // Text kept the same
              onPressed: () => _pickImage(ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700, // Darker Teal for secondary button
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),

            const SizedBox(height: 30),
            Divider(color: Colors.teal.shade200),
            const SizedBox(height: 30),

            // --- Extracted Text Section ---
            const Text(
              "Extracted Text:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 15),

            // Show loading indicator or extracted text
            if (_isProcessing)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: Colors.teal),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal, width: 1),
                ),
                child: Text(
                  _extractedText,
                  style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}