import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../viewModel/aiProcess_viewModel.dart';
import '../../dataSource/aiProcess_dataSource.dart';

class HistorySummaryPage extends StatelessWidget {
  final User user;
  final Map<String, String?> data;

  const HistorySummaryPage({Key? key, required this.user, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<AIProcessViewModel>(
      create: (context) => AIProcessViewModel(AIProcessDataSource()),
      child: Scaffold(
        appBar: AppBar(
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: 700,
                    height: 350,
                    color: Colors.grey[300],
                    child: data['image'] != null
                        ? Image.memory(
                      base64.decode(data['image']!),
                      fit: BoxFit.cover,
                    )
                        : Container(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    color: Colors.grey[200],
                    child: Text(
                      data['text_data'] != null
                          ? data['text_data']!
                          : '요약된 내용이 없습니다.',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
