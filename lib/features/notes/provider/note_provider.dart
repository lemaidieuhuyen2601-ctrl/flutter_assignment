import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/note_repository.dart';
import '../domain/note.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepository();
});

class NoteNotifier extends AsyncNotifier<List<Note>> {
  late final NoteRepository repository;

  @override
  Future<List<Note>> build() async {
    repository = ref.read(noteRepositoryProvider);

    return repository.getNotes();
  }

  Future<void> loadNotes() async {
    state = const AsyncLoading();

    try {
      final notes = await repository.getNotes();
      state = AsyncData(notes);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> createNote(Note note) async {
    state = const AsyncLoading();

    try {
      final notes = await repository.createNote(note);
      state = AsyncData(notes);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> deleteNote(String id) async {
    state = const AsyncLoading();

    try {
      final notes = await repository.deleteNote(id);
      state = AsyncData(notes);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> updateNote(Note note) async {
    state = const AsyncLoading();

    try {
      final notes = await repository.updateNote(note);
      state = AsyncData(notes);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

final noteProvider = AsyncNotifierProvider<NoteNotifier, List<Note>>(
  NoteNotifier.new,
);
