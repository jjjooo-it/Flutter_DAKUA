import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../viewModel/aiProcess_viewModel.dart';
import '../../dataSource/aiProcess_dataSource.dart';

class HistorySummaryPage extends StatefulWidget {
  final User user;
  final Map<String, String?> data;

  const HistorySummaryPage({Key? key, required this.user, required this.data}) : super(key: key);

  @override
  _HistorySummaryPageState createState() => _HistorySummaryPageState();
}

class _HistorySummaryPageState extends State<HistorySummaryPage> {
  bool _isExpanded = false;

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
                    child: widget.data['image'] != null
                        ? Image.memory(
                      base64.decode(widget.data['image']!),
                      fit: BoxFit.cover,
                    )
                        : Container(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: ExpansionPanelList(
                      expandedHeaderPadding: EdgeInsets.zero,
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                widget.data['text_data'] != null
                                    ? widget.data['text_data']!
                                    : '요약된 내용이 없습니다.',
                                style: TextStyle(fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                          body: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            child: Text(
                              widget.data['full_text_data'] != null
                                  ? widget.data['full_text_data']!
                                  : '전체 내용이 없습니다.',
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          isExpanded: _isExpanded,
                        ),
                      ],
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
