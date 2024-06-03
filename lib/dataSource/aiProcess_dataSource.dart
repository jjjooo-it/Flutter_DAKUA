//homePage에서 사용, 요약 생성하기 버튼을 눌렀을 때
//end-point : AI_process
//post 값 : user_id
//response 값 : summary_text, image

import 'dart:convert';
import 'package:http/http.dart' as http;

class AIProcessDataSource {
  final String baseUrl = "http://220.149.250.118:8000"; //실제 주소로 바꿔야함
  Future<Map<String, dynamic>> postUserId(String userId, String currentLanguage) async {
    print("api call  $userId");
    final uri = Uri.parse('http://220.149.250.118:8000/AI_process/');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user_id': userId,
        'language': currentLanguage
      }),
    );
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
      String? image = decodedResponse['image'];
      String? text_data = decodedResponse['text_data'];
      String? full_text_data = decodedResponse['full_text_data'];

      return {'image': image, 'text_data': text_data, 'full_text_data':full_text_data};
    } else {
      throw Exception('Failed to fetch summary data');
    }
  }
}
