import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://127.0.0.1/:8000/api/users/'; // Android Emulator IP

class ApiService {
  static Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
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
