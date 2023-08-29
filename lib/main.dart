import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial/screen/home.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/screen/note_adapter.dart';
import 'model/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes'); // Open the Hive box
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NoteListPage(),
    );
  }
}
