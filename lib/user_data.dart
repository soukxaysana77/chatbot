// lib/user_data.dart
class User {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});
}

// นี่คือลิสต์ที่จะเก็บ User ทั้งหมด
// static keyword ทำให้สามารถเข้าถึงได้จากที่ไหนก็ได้โดยไม่ต้องสร้าง instance ของคลาส
class UserDatabase {
  static final List<User> _users = [
    // เพิ่ม User เริ่มต้น (admin) เข้าไปในลิสต์
    User(username: 'admin', email: 'admin@example.com', password: '123456'),
  ];

  static void addUser(User user) {
    _users.add(user);
    print('User added: ${user.username}');
  }

  static User? getUserByUsername(String username) {
    try {
      return _users.firstWhere((user) => user.username == username);
    } catch (e) {
      return null; // ถ้าไม่พบ
    }
  }

  static bool verifyPassword(String username, String password) {
    final user = getUserByUsername(username);
    return user != null && user.password == password;
  }
}