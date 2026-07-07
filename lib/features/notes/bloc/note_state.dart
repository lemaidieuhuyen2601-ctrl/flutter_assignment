// import '../domain/note.dart';

// /// Lớp cha của tất cả State
// abstract class NoteState {
//   const NoteState();
// }

// /// Trạng thái ban đầu
// class NoteInitial extends NoteState {
//   const NoteInitial();
// }

// /// Đang xử lý dữ liệu
// class NoteLoading extends NoteState {
//   const NoteLoading();
// }

// /// Đã lấy dữ liệu thành công
// class NoteLoaded extends NoteState {
//   final List<Note> notes;

//   const NoteLoaded(this.notes);
// }

// /// Có lỗi xảy ra
// class NoteError extends NoteState {
//   final String message;

//   const NoteError(this.message);
// }