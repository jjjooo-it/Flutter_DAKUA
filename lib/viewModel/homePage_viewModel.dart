import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/aiData.dart';
import '../model/file.dart';

class HomePageViewModel extends ChangeNotifier {
  late AIData _aiData;
  late File _file;

  HomePageViewModel() {
    _file = File(attachedFileName: "");
    _aiData = AIData(
      loading: false,
      dataReceived: false,
      summarizeText: null,
    );
  }

  String? get attachedFileName => _file.attachedFileName;

  /////////////////////파일 첨부 동작/////////////////////
  // 파일 첨부 메서드
  Future<void> attachFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      _file.attachedFileName = file.name;
      print('Selected file: ${file.name}');
      notifyListeners();
    } else {
      print('File picking canceled.');
    }
  }

  // 파일 저장 메서드
  void saveToFile() {
    // 파일 저장 코드를 여기에 구현합니다.
    print("파일을 저장합니다.");
  }

  // 요약 기록 저장 다이얼로그 표시 메서드
  void showSaveRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("요약 기록을 저장하시겠습니까?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("저장 폴더 선택"),
              TextFormField(
                onChanged: (value) {
                  // 폴더 이름을 저장합니다.
                },
              ),
              SizedBox(height: 10),
              Text("저장 이름"),
              TextFormField(
                onChanged: (value) {
                  // 파일 이름을 저장합니다.
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                saveToFile(); // 파일 저장 메서드 호출
              },
              child: Text("예"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("아니요"),
            ),
          ],
        );
      },
    );
  }

  ////////////////AI 요약 데이터 받아오는 동작////////////////
  void resetDataReceived() {
    _aiData.dataReceived = false;
    notifyListeners();
  }

  AIData get result => _aiData;

  Future<void> fetchData() async {
    _aiData.setLoading(true);
    notifyListeners();

    final text =
        '머신러닝은 데이터 과학과 컴퓨터 공학의 교차점에 위치한 분야로, 컴퓨터가 데이터로부터 패턴을 발견하고 학습하여 작업을 자동화하거나 예측하는 기술입니다." 또한 머신러닝은 자율 주행 자동차, 음성 인식, 언어 번역, 추천 시스템 등 다양한 응용 분야에서 혁신을 이끌고 있습니다. 이러한 기술의 발전은 데이터의 양과 품질이 증가함에 따라 더욱 가속화되고 있으며, 머신러닝은 미래의 기술과 산업을 선도하는 핵심 역할을 수행할 것으로 기대됩니다.';

    final response = await http.post(
        Uri.parse('http://**********/AI_process/?text=$text'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final summarizeText = jsonResponse['summarize_text'];

      _aiData.setDataReceived(true);
      _aiData.setLoading(false);
      _aiData.setSummarizeText(summarizeText);
      notifyListeners();
    } else {
      _aiData.setLoading(false);
      notifyListeners();
      throw Exception('Failed to load data');
    }
  }
}
