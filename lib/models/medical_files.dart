// Placeholder for your actual medical_file.dart structure
// You MUST ensure your model has this structure for the solution to work.

class MedicalFile {
  String path;
  String name;
  DateTime date;

  MedicalFile({required this.path, required this.name, required this.date});

  // Method to convert a MedicalFile object to a JSON map
  Map<String, dynamic> toJson() => {
    'path': path,
    'name': name,
    'date': date.toIso8601String(), // Save DateTime as a standardized string
  };

  // Factory constructor to create a MedicalFile from a JSON map
  factory MedicalFile.fromJson(Map<String, dynamic> json) => MedicalFile(
    path: json['path'] as String,
    name: json['name'] as String,
    date: DateTime.parse(json['date'] as String),
  );
}