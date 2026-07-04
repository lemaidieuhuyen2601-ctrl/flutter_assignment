import '../domain/note.dart';

//Chứa Repository. Nơi thêm, sửa, xóa, lấy dữ liệu
class NoteRepository {
  final List<Note> _notes = [];

  // Lấy danh sách Note
  Future<List<Note>> getNotes() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.from(_notes);
  }

  // Thêm Note
  Future<List<Note>> createNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _notes.add(note);

    return List.from(_notes);
  }

  // Xóa Note
  Future<List<Note>> deleteNote(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _notes.removeWhere((note) => note.id == id);

    return List.from(_notes);
  }

  // Cập nhật Note
  Future<List<Note>> updateNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _notes.indexWhere((item) => item.id == note.id);

    if (index != -1) {
      _notes[index] = note;
    }

    return List.from(_notes);
  }
}
