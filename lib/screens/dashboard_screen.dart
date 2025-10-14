import 'dart:io';
import 'dart:convert'; // Import for JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // Required for persistent storage path
import 'package:mediscanai/models/medical_files.dart';
import 'package:open_filex/open_filex.dart' show OpenFilex, OpenResult;


import 'add_file_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<MedicalFile> _files = [];
  String _searchQuery = '';
  late File _metadataFile; // File to store the list metadata

  @override
  void initState() {
    super.initState();
    _initializePersistence(); // Initialize the file and load data
  }

  // --- Persistence Methods ---

  Future<void> _initializePersistence() async {
    final directory = await getApplicationDocumentsDirectory();
    _metadataFile = File('${directory.path}/medical_files_metadata.json');
    await _loadFiles();
  }

  Future<void> _saveFiles() async {
    // 1. Convert the list of MedicalFile objects to a list of JSON maps
    final List<Map<String, dynamic>> jsonList =
    _files.map((file) => file.toJson()).toList();

    // 2. Encode the list to a single JSON string
    final String jsonString = jsonEncode(jsonList);

    // 3. Write the string to the persistence file
    await _metadataFile.writeAsString(jsonString);
  }

  Future<void> _loadFiles() async {
    if (await _metadataFile.exists()) {
      try {
        // 1. Read the JSON string from the file
        final String jsonString = await _metadataFile.readAsString();

        // 2. Decode the JSON string back into a list of dynamic maps
        final List<dynamic> jsonList = jsonDecode(jsonString);

        // 3. Convert the list of maps back into a list of MedicalFile objects
        final List<MedicalFile> loadedFiles = jsonList
            .map((json) => MedicalFile.fromJson(json as Map<String, dynamic>))
            .toList();

        setState(() {
          _files = loadedFiles;
        });
      } catch (e) {
        // Handle potential decoding errors (e.g., file corruption)
        print("Error loading files: $e");
        setState(() {
          _files = []; // Reset list on error
        });
      }
    }
  }

  // --- File Management Methods (Now call _saveFiles) ---

  void _addFile(MedicalFile file) {
    setState(() {
      _files.add(file);
      _saveFiles(); // SAVE after adding
    });
  }

  void _renameFile(MedicalFile file) async {
    final controller = TextEditingController(text: file.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Rename File", style: TextStyle(color: Colors.teal)), // Teal title
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.teal)), // Teal focus
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.teal))),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text("Save", style: TextStyle(color: Colors.teal))),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        file.name = newName;
        _saveFiles(); // SAVE after renaming
      });
    }
  }

  void _deleteFile(MedicalFile file) {
    setState(() {
      // Safely check if the file exists before attempting to delete it
      if (File(file.path).existsSync()) {
        File(file.path).deleteSync();
      }
      _files.remove(file);
      _saveFiles(); // SAVE after deleting
    });
  }

  // lib/screen/dashboard_screen.dart

  // lib/screen/dashboard_screen.dart

  // lib/screen/dashboard_screen.dart

  // lib/screen/dashboard_screen.dart

  void _openFile(String path) async {
    // OpenFilex and OpenResult should still be imported.
    final result = await OpenFilex.open(path);

    // FINAL FIX: Check the result type against the success code (0).
    // The type is an integer, and 0 means success.
    if (result.type != 0) { // <--- CHANGE IS HERE
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // Note: result.message will contain the actual error details.
          content: Text("Could not open file: ${result.message}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredFiles = _files
        .where((file) => file.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("MediSave Dashboard"),
        backgroundColor: Colors.teal, // Teal AppBar
        // --- Custom Search Bar below AppBar ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search files...",
                prefixIcon: const Icon(Icons.search, color: Colors.teal), // Teal search icon
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder( // Teal border when focused
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.teal, width: 2),
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
        ),
      ),
      body: filteredFiles.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 80, color: Colors.teal), // Teal icon
            SizedBox(height: 10),
            Text(
              "No files added yet",
              style: TextStyle(fontSize: 16, color: Colors.teal),
            ),
          ],
        ),
      )
          : ListView.separated( // Use ListView.separated for dividers
        padding: const EdgeInsets.only(top: 8.0),
        itemCount: filteredFiles.length,
        separatorBuilder: (context, index) => const Divider(height: 1, indent: 20, endIndent: 20, color: Colors.grey),
        itemBuilder: (context, index) {
          final file = filteredFiles[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal.shade100, // Light teal background
              child: Icon(Icons.file_copy, color: Colors.teal), // Teal file icon
            ),
            title: Text(
              file.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Date: ${file.date.toLocal().toString().split(' ')[0]}"),
            trailing: PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.teal), // Teal menu icon
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'rename',
                  child: const Text("Rename"),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: const Text("Delete"),
                ),
              ],
              onSelected: (value) {
                if (value == 'rename') _renameFile(file);
                if (value == 'delete') _deleteFile(file);
              },
            ),
            onTap: () => _openFile(file.path),
          );
        },
      ),
      // --- Floating Action Button ---
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal, // Teal FAB background
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddFileScreen(onFileSaved: _addFile)),
          );
        },
        child: const Icon(Icons.add, color: Colors.white), // White icon
      ),
    );
  }
}