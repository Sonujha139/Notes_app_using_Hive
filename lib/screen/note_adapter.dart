import 'package:hive/hive.dart';
import '../model/models.dart';

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0; // Unique ID for this adapter

  @override
  Note read(BinaryReader reader) {
    return Note(
      title: reader.readString(),
      description: reader.readString(),
      category: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeString(obj.category);
  }
}
