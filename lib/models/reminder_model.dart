import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class Reminder extends HiveObject {
  @HiveField(0)
  late String medicineName;

  @HiveField(1)
  late List<String> times; // e.g., ["09:00 AM", "02:00 PM"]

  Reminder({
    required this.medicineName,
    required this.times,
  });
}
