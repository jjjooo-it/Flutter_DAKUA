import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../dataSource/aiProcess_dataSource.dart';
import '../../dataSource/fileAttach_dataSource.dart';
import '../../dataSource/saveSummary_dataSource.dart';
import '../../model/user.dart';
import '../../viewModel/aiProcess_viewModel.dart';
import '../../viewModel/fileAttach_viewModel.dart';
import '../../viewModel/saveSummary_viewModel.dart';
import '../widget/appBar.dart';
import 'loading_summary_Page.dart';
import 'resultDetailPage.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AIProcessViewModel>(
          create: (context) => AIProcessViewModel(AIProcessDataSource()),
        ),
        ChangeNotifierProvider<FileAttachViewModel>(
          create: (context) =>
              FileAttachViewModel(FileAttachDataSource(), widget.user),

        ),
        ChangeNotifierProvider<SaveSummaryViewModel>(
          create: (context) =>
              SaveSummaryViewModel(SaveSummaryDataSource()),
        ),
      ],
      child: Consumer3<AIProcessViewModel, FileAttachViewModel,SaveSummaryViewModel>(
        builder: (context, aiViewModel, fileAttachViewModel,saveSummaryViewModel, child) {
          if (aiViewModel.loading) {
            return LoadingSummaryPage();
          } else {
            return ChangeNotifierProvider<FileAttachViewModel>(
              create: (context) =>
                  FileAttachViewModel(FileAttachDataSource(), widget.user),
              child: Scaffold(
                appBar: AppBarWidget(),
                body: Center(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Consumer2<AIProcessViewModel,
                          FileAttachViewModel>(
                        builder: (context, aiViewModel, fileAttachViewModel,
                            child) {
                          if (aiViewModel.dataReceived) {
                            return Column(
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          aiViewModel.dataReceived = false;

                                        });
                                      },
                                      child: Text(
                                        'otherFileButton'.tr(),
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Container(
                                  width: 230,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'completeSummary'.tr(),
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: 700,
                                  height: 350,
                                  color: Colors.grey[300],
                                  child: aiViewModel.aiSummary?.image != null
                                      ? Image.memory(
                                    base64.decode(
                                        aiViewModel.aiSummary!.image!),
                                    fit: BoxFit.cover,
                                  )
                                      : Container(),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  color: Colors.grey[200],
                                  child: Text(
                                    aiViewModel.aiSummary?.summaryText != null
                                        ? aiViewModel.aiSummary!.summaryText!
                                        : 'noSummaryMessage'.tr(),
                                    style: TextStyle(fontSize: 16.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 30),
                                SizedBox(
                                  height: 60,
                                  width: 300,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.greenAccent,
                                          Colors.blueGrey
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(40.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        saveSummaryViewModel.showSaveRecordDialog(context, widget.user.userId!);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                       child: Text(
                                        'saveRecordButton'.tr(),
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: CarouselSlider(
                                    items: [
                                      Center(
                                          child: Text(
                                            'summaryGeneratingMessage'.tr(),
                                            style: TextStyle(fontSize: 16.0),
                                          )),
                                      Center(
                                          child: Text(
                                            'summarization'.tr(),
                                            style: TextStyle(fontSize: 18.0),
                                          )),
                                      Center(
                                          child: Text(
                                            'advertisementMessage'.tr(),
                                            style: TextStyle(fontSize: 18.0),
                                          )),
                                    ],
                                    options: CarouselOptions(
                                      height: 50,
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      autoPlay: true,
                                      autoPlayInterval:
                                      Duration(seconds: 10),
                                      autoPlayAnimationDuration:
                                      Duration(milliseconds: 8000),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 100.0),
                                Text(
                                  'recordAttachmentTitle'.tr(),
                                  style: TextStyle(fontSize: 18.0),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20.0),
                                ElevatedButton(
                                  onPressed: () =>
                                      fileAttachViewModel.selectFile(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: 230,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        fileAttachViewModel.filePath != null
                                            ? '${fileAttachViewModel.filePath}'
                                            : 'noFileSelected'.tr(),
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 150.0),
                                SizedBox(
                                  height: 60,
                                  width: 300,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.greenAccent,
                                          Colors.blueGrey
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(40.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (fileAttachViewModel.filePath !=
                                            null) {
                                          print("ai process start");
                                          aiViewModel.postUserId(
                                              widget.user.userId!);
                                        } else {
                                          print("No file selected.");
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        'generateSummaryButton'.tr(),
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
  void _navigateToResultPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultDetailPage()),
    );
  }
}
