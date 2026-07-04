import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/notes/data/note_repository.dart';
import 'features/notes/bloc/note_bloc.dart';
import 'features/notes/presentation/note_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc(
        repository: NoteRepository(),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NotePage(title: 'Flutter Demo Home Page'),
      ),
    );

  }
}
