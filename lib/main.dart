import 'package:flutter/material.dart';
import 'dart:math';

// ================= MODEL =================

class Note {

  final String id;
  final String title;
  final String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });

}



// ================= SERVICE =================

class NoteApiService {

  Future<List<Note>> getNotes() async {

    // giả lập gọi API
    await Future.delayed(
      Duration(seconds: 2),
    );

    // 20% lỗi
    if(Random().nextInt(10) < 2){
      throw Exception("Network Error");
    }

    return [

      Note(
        id: "1",
        title: "Flutter",
        content: "Learn Future",
      ),

      Note(
        id: "2",
        title: "Dart",
        content: "Learn async await",
      ),
    ];
  }

  Future<Note> createNote(Note note) async {

    await Future.delayed(
      Duration(seconds: 2),
    );

    if(Random().nextInt(10) < 2){
      throw Exception("Network Error");
    }

    return note;
  }

  Future<void> deleteNote(String id) async {

    await Future.delayed(
      Duration(seconds: 2),
    );

    if(Random().nextInt(10) < 2){
      throw Exception("Network Error");
    }

  }
}

// ================= APP =================
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final api = NoteApiService();
  late Future<List<Note>> notesFuture;
  
  @override
  void initState(){
    super.initState();
    notesFuture = api.getNotes();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,     
        title: Text("Notes"),
      ),

      body: FutureBuilder<List<Note>>(
        future: notesFuture,

        builder:(context, snapshot){
          // Loading
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: Text(
                "Loading notes..."
              ),
            );
          }

          // Error
          if(snapshot.hasError){
            return Center(
              child: Text(
                "Failed to load notes"
              ),
            );
          }

          // Success
          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,

            itemBuilder:(context,index){
              return ListTile(
                title: Text(
                  notes[index].title
                ),

                subtitle: Text(
                  notes[index].content
                ),
              );
            },

          );
        },
      ),
    );
  }
}
