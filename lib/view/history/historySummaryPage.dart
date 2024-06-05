import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../viewModel/aiProcess_viewModel.dart';
import '../../dataSource/aiProcess_dataSource.dart';
import '../widget/appBar.dart';

class HistorySummaryPage extends StatefulWidget {
  final String folder;
  final List<String> files;
  final User user;
  final Map<String, String?> data;

  const HistorySummaryPage(
      {required this.folder, required this.files, Key? key, required this.user, required this.data})
      : super(key: key);


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
        appBar: AppBarWidget(),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'pageTitle'.tr(),
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    color: Colors.grey[200],
                    child: Text(
                      "folderPrefix".tr() + widget.folder,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),

                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
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
                                _isExpanded
                                    ? widget.data['full_text_data'] ?? 'no_full'.tr()
                                    : widget.data['text_data'] ?? 'no_summary'.tr(),
                                style: TextStyle(fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                          body: _isExpanded
                              ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            child: Text(
                              "",
                              style: TextStyle(fontSize: 0.0),
                              textAlign: TextAlign.center,
                            ),
                          )
                              : Container(),
                          isExpanded: _isExpanded,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
    );
  }
}
