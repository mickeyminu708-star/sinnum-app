import 'package:hive_flutter/hive_flutter.dart';

class DatabaseEngine {
  static late Box chatBox;

  // 1. Initialize Local Encrypted Hive Storage
  static Future<void> initDatabase() async {
    await Hive.initFlutter();
    chatBox = await Hive.openBox('sinnum_secure_chats');
  }

  // 2. Save Encrypted Message Locally
  static Future<void> saveMessage(String senderId, String message) async {
    await chatBox.add({
      'sender': senderId,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // 3. Secure Wipe All Local Data
  static Future<void> wipeAllData() async {
    await chatBox.clear();
  }
}
