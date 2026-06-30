import 'package:flutter/material.dart';
import 'dart:async';

// MODEL
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

// REPOSITORY + STREAM CONTROLLER
class NoteRepository {

  // nơi phát dữ liệu
  final StreamController<List<Note>> _controller =
      StreamController<List<Note>>.broadcast();

  // danh sách lưu note
  final List<Note> _notes = [];

  // Stream cho UI nghe
  Stream<List<Note>> get notesStream =>
      _controller.stream;

  // tạo note mới
  void addNote(Note note){
    _notes.add(note);

    // phát dữ liệu mới
    _controller.add(_notes);
  }

  void dispose(){
    _controller.close();
  }

}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final NoteRepository repository =
    NoteRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: NotePage(
        repository: repository,
      ),
    );
  }
}

// UI
class NotePage extends StatelessWidget {
  final NoteRepository repository;

  const NotePage({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Realtime Notes"
        ),
      ),

      body: StreamBuilder<List<Note>>(
        stream: repository.notesStream,

        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text(
                "No notes"
              ),
            );
          }

          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,

            itemBuilder: (context,index){
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

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          repository.addNote(
            Note(
              id: DateTime.now().toString(),
              title: "New Note",
              content: "Hello Stream",
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "New note received"
              ),
            ),
          );

        },

        child: Icon(
          Icons.add
        ),

      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: .center,
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
