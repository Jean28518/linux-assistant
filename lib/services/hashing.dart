import 'package:crypto/crypto.dart';
import 'dart:convert';

class Hashing {
  static String getMd5OfString(String string) {
    var bytes = utf8.encode(string); // data being hashed
    var digest = md5.convert(bytes);
    return digest.toString();
  }
}
