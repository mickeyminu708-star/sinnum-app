
import 'dart:convert';
import 'package:cryptography/cryptography.dart';

class CryptoEngine {
  static Future<String> encryptMessage(
    String plainText,
    String sharedSecretKey,
  ) async {
    final algorithm = AesGcm.with256Bits();
    final secretKeyBytes = utf8.encode(
      sharedSecretKey.padRight(32, '0').substring(0, 32),
    );
    final secretKey = SecretKey(secretKeyBytes);

    final secretBox = await algorithm.encrypt(
      utf8.encode(plainText),
      secretKey: secretKey,
    );

    return base64Encode(secretBox.concatenation());
  }

  static Future<String> decryptMessage(
    String encryptedBase64,
    String sharedSecretKey,
  ) async {
    final algorithm = AesGcm.with256Bits();
    final secretKeyBytes = utf8.encode(
      sharedSecretKey.padRight(32, '0').substring(0, 32),
    );
    final secretKey = SecretKey(secretKeyBytes);

    final combinedBytes = base64Decode(encryptedBase64);
    final secretBox = SecretBox.fromConcatenation(
      combinedBytes,
      nonceLength: algorithm.nonceLength,
      macLength: algorithm.macLength,
    );

    final decryptedBytes = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );

    return utf8.decode(decryptedBytes);
  }
}
