import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late String category;

  int? hiveKey; // Hive key for storing objects

  // Add a constructor to create a Note instance with Hive key
  Note({
    required this.title,
    required this.description,
    required this.category,
  });
}
