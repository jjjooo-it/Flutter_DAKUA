//homePage에서 사용, 파일 붙이기 및 전처리
//end-point : Audio_preprocess
//post 값 : file, user_id

import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../model/attachedFile.dart';
import '../model/user.dart';


class FileAttachDataSource {
  Future<void> uploadFile(User user, Uint8List voiceFile, String fileName) async {
    var uri = Uri.parse('http://220.149.250.118:8000/Audio_preprocess');

    var request = http.MultipartRequest('POST', uri);
    request.fields['user_id'] = user.userId!;

    // 파일을 MultipartFile로 변환하여 요청에 추가
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        voiceFile,
        filename: fileName,
        contentType: MediaType.parse(lookupMimeType(fileName) ?? 'application/octet-stream'),
      ),
    );

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('Failed to upload file: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }
}
