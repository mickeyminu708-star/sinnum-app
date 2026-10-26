
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseEngine {
  static late Box chatBox;

  static Future<void> initDatabase() async {
    await Hive.initFlutter();
    chatBox = await Hive.openBox('sinnum_secure_chats');
  }

  static Future<void> saveMessage(
    String senderId,
    String message,
  ) async {
    await chatBox.add({
      'sender': senderId,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
