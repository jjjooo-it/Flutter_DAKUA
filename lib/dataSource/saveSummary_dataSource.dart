//저장하기 버튼을 눌렀을 때 동작
//end-point : Save_user_data
//post 값 : user_id, folder_name, file_name


import 'dart:convert';
import 'package:http/http.dart' as http;

class SaveSummaryDataSource {
  Future<void> saveUserData(String userId, String folderName, String fileName) async {
    final uri = Uri.parse('http://220.149.250.118:8000/Save_user_data/');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'user_id': userId,
        'folder_name': folderName,
        'file_name': fileName,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save user data: ${response.body}');
    }
  }




  Future<List<Map<String, dynamic>>> fetchFolderData(String userId) async {
    final response = await http.post(
      Uri.parse('http://220.149.250.118:8000/Get_Folder_Name/?user_id=${userId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
      return List<Map<String, dynamic>>.from(responseData);
    } else {
      throw Exception('Failed to fetch folder data');
    }
  }
}

