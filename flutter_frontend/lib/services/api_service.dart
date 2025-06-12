import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/app_logger.dart';

const String baseUrl = 'http://127.0.0.1/:8000/api/users/'; 

class ApiService {
  static Future<List<dynamic>> fetchUsers() async {
    appLogger.i('ApiService: Fetching users from $baseUrl');
    try{    
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        appLogger.d('ApiService: fetchUsers - Status Code: ${response.statusCode}. Body: ${response.body.substring(0, response.body.length < 200 ? response.body.length : 200)}...');
        return jsonDecode(response.body);
      } else {
        appLogger.w('ApiService: fetchUsers - Failed with status ${response.statusCode}. Body: ${response.body}');
        throw Exception('Failed to load users');
      }
    } catch (e,s){
      appLogger.e('ApiService: fetchUsers - Error: $e', error: e, stackTrace: s);
      throw Exception('Failed to load users: $e');
    }

  }

  static Future<http.Response> createUser(Map<String, String> data, File? image) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('profile_picture', image.path));
    }
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  static Future<http.Response> deleteUser(int id) async {
    return await http.delete(Uri.parse('$baseUrl$id/'));
  }

  // Add updateUser() here if needed
}
