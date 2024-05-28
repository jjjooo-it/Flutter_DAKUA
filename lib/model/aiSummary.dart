//요약 생성하기 버튼을 클릭할 때 받을 데이터들
//response
//post할 데이터는 user.dart
//summarizeText, image

import 'dart:convert';

class AISummary{
  String? summaryText;
  String? image;

  AISummary({
    required this.summaryText,
    required this.image,
  });

  factory AISummary.fromJson(Map<String, dynamic> json) {
    return AISummary(
      summaryText: json['summarize_text'] != null ? utf8.decode(json['summarize_text'].codeUnits) : null,
      image: json['image'],
    );
  }

  void setSummarizeText(String? value) {
    summaryText = value;
  }
  void setImage(String? value) {
    image = value;
  }
}
