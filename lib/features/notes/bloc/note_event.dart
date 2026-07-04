import '../domain/note.dart';

/// Lớp cha của tất cả Event
abstract class NoteEvent {
  const NoteEvent();
}

/// Khi mở ứng dụng
class LoadNotes extends NoteEvent {
  const LoadNotes();
}

/// Khi tạo Note mới
class CreateNote extends NoteEvent {
  final Note note;

  const CreateNote(this.note);
}

/// Khi xóa Note
class DeleteNote extends NoteEvent {
  final String id;

  const DeleteNote(this.id);
}

/// Khi cập nhật Note
class UpdateNote extends NoteEvent {
  final Note note;

  const UpdateNote(this.note);
}