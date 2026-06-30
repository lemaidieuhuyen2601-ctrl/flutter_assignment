TASK 1 + 2:
- Dùng các lệnh git innit, git add ., git remote add origin https://github.com/lemaidieuhuyen2601-ctrl/flutter_assignment, git branch -M main, git push -u origin main để thêm git vào project, kết nối và đưa các file lên Github.
- Tạo branch mới (feature/note-api) cho Task 2 và code ở branch đó tránh ảnh hưởng đến main bằng lệnh git checkout -b feature/note-api và sau đó commit bằng lệnh git commit -m "feat: create note api layer".
- Trong branch feature/note-api:
  + Tạo class NoteApiService {
            Future<List<Note>> getNotes();
            Future<Note> createNote(Note note);
            Future<void> deleteNote(String id);
        } 
    với mỗi cái đều giả lập gọi API sau 2s trả về kết quả:
        await Future.delayed(
            Duration(seconds: 2),
        );
    và giả sử 20% request bị lỗi:
        if (Random().nextInt(10) < 2) {
            throw Exception('Network Error');
        }
  + Trong lúc request đang loading chờ xử lí thì UI hiển thị "Loading notes..."
  + Khi đã xử lí xong rồi Future sẽ trả về một trong 2 kết quả: Nếu Error thì UI hiển thị "Failed to load notes", nếu Sucesss thì UI hiển thị danh sách Note.
- Dùng lệnh git add . và git push origin feature/note-api để đẩy code và branch lên Github.
- Dùng lệnh git checkout main để quay về branch main và tiếp tục tạo 2 branch còn lại: feature/bloc và feature/bloc. Sau đó commit: git commit -m "feat: implement note bloc", git commit -m "feat: implement realtime notes"

TASK 3:
- Tạo Model Note đại diện cho dữ liệu của một ghi chú. Trong Note có các thông tin như id, title và content.
- Tạo Repository để quản lý dữ liệu. Repository đóng vai trò trung gian giữa UI và Stream. Thay vì UI tự lấy dữ liệu hoặc dùng setState() để cập nhật danh sách, Repository sẽ chịu trách nhiệm thêm note mới và thông báo cho UI khi dữ liệu thay đổi.
- Trong Repository, dùng:
        StreamController<List<Note>> 
  để tạo một nơi phát dữ liệu. 
  + Khi có một note mới được tạo thì dùng:
        _controller.add()
  để đưa danh sách note mới vào Stream.
- Ở UI thay vì dùng setState() để refresh dữ liệu thì dùng StreamBuilder<List<Note>> để khi Stream phát ra dữ liệu mới thì StreamBuilder tự động cập nhật danh sách hiển thị.
- Về cách hoạt động:
  + Khi người dùng tạo Note thì Repository nhận Note mới, sau đó StreamController sẽ phát dữ liệu rồi Stream gửi dữ liệu tới UI và StreamBuilder tự rebuild giao diện. 
  + Kết quả: mỗi lần người dùng nhấn tạo Note thì sẽ xuất hiện một Note mới có title:... và nội dung:... và sẽ có một thông báo "New note received" xuất hiện với mỗi lần 1 Note mới được tạo.



