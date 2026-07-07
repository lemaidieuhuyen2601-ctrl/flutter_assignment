//Toàn bộ UI

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/note_provider.dart';
import '../domain/note.dart';

class NotePage extends ConsumerStatefulWidget {
  const NotePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  String? selectedNoteId;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noteProvider.notifier).loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body: Column(
        children: [
          // ================= INPUT =================
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(labelText: "Content"),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    ElevatedButton(
                      onPressed: selectedNoteId != null
                          ? null
                          : () {
                              final newNote = Note(
                                id: DateTime.now().toString(),
                                title: titleController.text,
                                content: contentController.text,
                              );

                              ref
                                  .read(noteProvider.notifier)
                                  .createNote(newNote);

                              titleController.clear();
                              contentController.clear();
                            },
                      child: const Text("Add"),
                    ),

                    const SizedBox(width: 10),

                    ElevatedButton(
                      onPressed: selectedNoteId == null
                          ? null
                          : () {
                              final updatedNote = Note(
                                id: selectedNoteId!,
                                title: titleController.text,
                                content: contentController.text,
                              );

                              ref
                                  .read(noteProvider.notifier)
                                  .updateNote(updatedNote);

                              titleController.clear();
                              contentController.clear();
                              setState(() {
                                selectedNoteId = null;
                              });
                            },
                      child: const Text("Update"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: Builder(
              builder: (context) {
                final state = ref.watch(noteProvider);

                return state.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),

                  error: (error, stackTrace) {
                    return Center(
                      child: Text(error.toString()),
                    );
                  },

                  data: (notes) {
                    return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];

                        return ListTile(
                          title: Text(note.title),
                          subtitle: Text(note.content),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    selectedNoteId = note.id;
                                    titleController.text = note.title;
                                    contentController.text = note.content;
                                  });
                                },
                              ),

                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  ref
                                      .read(noteProvider.notifier)
                                      .deleteNote(note.id);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),          
        ],
      ),
    );
  }
}
