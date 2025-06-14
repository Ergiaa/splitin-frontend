import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {

  static String get baseUrl => dotenv.env['BACKEND_URL'] ?? 'http://localhost:5000';
  static String get authUrl => '$baseUrl/auth';
  static String get userUrl => '$baseUrl/user';
  

}