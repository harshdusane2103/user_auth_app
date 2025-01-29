import 'dart:convert';
import 'package:http/http.dart' as http;

class ImgurApiHelper {
  static const String _clientId = "636dc0c906a5a96";
  static const String _baseUrl = "https://api.imgur.com/3/image";

  // Upload Image (Base64)
  static Future<Map<String, dynamic>> uploadImage(String base64Image) async {
    final url = Uri.parse(_baseUrl);
    final headers = {
      "Authorization": "Client-ID $_clientId",
      "Content-Type": "application/json"
    };

    final body = jsonEncode({"image": base64Image, "type": "base64"});

    final response = await http.post(url, headers: headers, body: body);
    return _handleResponse(response);
  }

  // Get Image Details
  static Future<Map<String, dynamic>> getImage(String imageHash) async {
    final url = Uri.parse("$_baseUrl/$imageHash");
    final headers = {"Authorization": "Client-ID $_clientId"};

    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  // Delete Image
  static Future<Map<String, dynamic>> deleteImage(String imageDeleteHash) async {
    final url = Uri.parse("$_baseUrl/$imageDeleteHash");
    final headers = {"Authorization": "Client-ID $_clientId"};

    final response = await http.delete(url, headers: headers);
    return _handleResponse(response);
  }

  // Handle API Response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return decoded;
    } else {
      throw Exception("Error: ${decoded['data']['error']}");
    }
  }
}
