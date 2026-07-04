import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/note_repository.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository repository;

  NoteBloc({required this.repository}) : super(const NoteInitial()) {
    on<LoadNotes>(_onLoadNotes);

    on<CreateNote>(_onCreateNote);

    on<DeleteNote>(_onDeleteNote);

    on<UpdateNote>(_onUpdateNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(const NoteLoading());

    try {
      final notes = await repository.getNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _onCreateNote(CreateNote event, Emitter<NoteState> emit) async {
    emit(const NoteLoading());

    try {
      final notes = await repository.createNote(event.note);

      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    emit(const NoteLoading());

    try {
      final notes = await repository.deleteNote(event.id);

      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    emit(const NoteLoading());

    try {
      final notes = await repository.updateNote(event.note);

      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }
}
