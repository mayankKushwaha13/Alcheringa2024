import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

class GCM {
  static const int TAG_LENGTH = 16;
  static const int IV_LENGTH = 12;
  static const int SALT_LENGTH = 16;
  static const int KEY_LENGTH = 32;
  static const int ITERATIONS = 65535;

  static Uint8List getRandomNonce(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
        List<int>.generate(length, (_) => random.nextInt(256)));
  }

  static Uint8List getSecretKey(String password, Uint8List salt) {
    final pbkdf2Params = Pbkdf2Parameters(salt, ITERATIONS, KEY_LENGTH);
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA512Digest(), 64));
    pbkdf2.init(pbkdf2Params);
    return pbkdf2.process(utf8.encode(password));
  }

  static String encrypt(String password, String plainMessage) {
    final salt = getRandomNonce(SALT_LENGTH);
    final secretKey = getSecretKey(password, salt);
    final iv = getRandomNonce(IV_LENGTH);

    final encrypter = Encrypter(AES(Key(secretKey), mode: AESMode.gcm));
    final encrypted = encrypter.encrypt(plainMessage, iv: IV(iv));

    final combined = Uint8List.fromList(salt + iv + encrypted.bytes);
    return base64.encode(combined);
  }

  static String decrypt(String cipherContent, String password) {
    final decoded = base64.decode(cipherContent);
    final salt = decoded.sublist(0, SALT_LENGTH);
    final iv = decoded.sublist(SALT_LENGTH, SALT_LENGTH + IV_LENGTH);
    final cipherText = decoded.sublist(SALT_LENGTH + IV_LENGTH);

    final secretKey = getSecretKey(password, salt);

    final encrypter = Encrypter(AES(Key(secretKey), mode: AESMode.gcm));
    final decrypted = encrypter.decrypt(Encrypted(cipherText), iv: IV(iv));

    return decrypted;
  }
}
