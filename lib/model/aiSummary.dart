//요약 생성하기 버튼을 클릭할 때 받을 데이터들
//response
//post할 데이터는 user.dart
//summarizeText, image

import 'dart:convert';

class AISummary{
  String? text_data;
  String? full_text_data;
  String? image;

  AISummary({
    required this.text_data,
    required this.full_text_data,
    required this.image,
  });

  factory AISummary.fromJson(Map<String, dynamic> json) {
    return AISummary(
      text_data: json['text_data'] != null ? json['text_data'] : null,
      full_text_data: json['full_text_data'] != null ? json['full_text_data'] : null,
      image: json['image'],
    );
  }

  void setImage(String? value) {
    image = value;
  }
}
