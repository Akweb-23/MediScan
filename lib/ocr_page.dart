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
  // Use a TextEditingController to manage the editable text field
  final TextEditingController _textController = TextEditingController(text: "No text found yet");
  bool _isProcessing = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _textController.text = "Processing image...";
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

      // Update the controller's text instead of a simple String variable
      _textController.text = recognizedText.text.isNotEmpty
          ? recognizedText.text
          : "No text found yet";

    } catch (e) {
      _textController.text = "Error during recognition.";
    } finally {
      setState(() {
        _isProcessing = false;
      });
      textRecognizer.close();
    }
  }

  void _handleProceed() {
    // Logic for the Proceed button goes here
    // Example: show the final edited text
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Proceeding with edited text: ${_textController.text}"),
        backgroundColor: Colors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prescription OCR"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
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
              label: const Text("Capture from Camera"),
              onPressed: () => _pickImage(ImageSource.camera),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text("Pick from Gallery"),
              onPressed: () => _pickImage(ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),

            const SizedBox(height: 30),
            Divider(color: Colors.teal.shade200),
            const SizedBox(height: 30),

            // --- Extracted Text Section ---
            const Text(
              "Extracted Text (Editable):",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 15),

            // Show loading indicator or editable text field
            if (_isProcessing)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: Colors.teal),
                ),
              )
            else
            // Changed from Text to TextField
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal, width: 1),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: null, // Allows multiline input
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Edit the extracted text here...",
                    border: InputBorder.none, // Remove default border
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                ),
              ),

            const SizedBox(height: 20),

            // --- Proceed Button ---
            ElevatedButton.icon(
              onPressed: _handleProceed,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text("Proceed"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600, // Use a distinct color for the action
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}