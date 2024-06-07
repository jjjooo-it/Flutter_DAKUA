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
  late final Map<String, String?> data;
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    String currentLanguage = context.locale.languageCode;
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
                    child: Center(
                      child: Consumer2<AIProcessViewModel,
                          FileAttachViewModel>(
                        builder: (context, aiViewModel, fileAttachViewModel,
                            child) {
                          if (aiViewModel.dataReceived) {
                            return SingleChildScrollView(
                              child: Column(
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
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            side: BorderSide(color: Colors.grey,
                                            ),
                                          ),
                                        ),
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
                                  SizedBox(height: 20),
                                  Container(
                                    width: 700,
                                    height: 350,
                                    color: Colors.grey[300],
                                    child:  aiViewModel.aiSummary?.image!= null
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
                                               _isExpanded? aiViewModel.aiSummary?.full_text_data ?? 'no_full'.tr()
                                                    :   aiViewModel.aiSummary!.text_data ?? 'no_summary'.tr(),
                                                style: TextStyle(fontSize: 16.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          },
                                          body: _isExpanded?
                                          Container(
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
                                  SizedBox(height: 50),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: CarouselSlider(
                                    items: [
                                      Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.info, color: Colors.blue, size: 24),
                                            SizedBox(width: 10),
                                            Text(
                                              'summaryGeneratingMessage'.tr(),
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.text_snippet, color: Colors.green, size: 24),
                                            SizedBox(width: 10),
                                            Text(
                                              'summarization'.tr(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.ad_units, color: Colors.red, size: 24),
                                            SizedBox(width: 10),
                                            Text(
                                              'advertisementMessage'.tr(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    options: CarouselOptions(
                                      height: 100,
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      enableInfiniteScroll: true, //무한 스크롤 활성화
                                      autoPlay: true, //자동 재생 활성화
                                      autoPlayInterval:
                                      Duration(seconds: 2), //자동 재생 간격
                                      autoPlayAnimationDuration:
                                      Duration(milliseconds: 2000), //자동 재생 애니메이션 시간
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 100.0),
                                Text(
                                  'recordAttachmentTitle'.tr(),
                                  style: TextStyle(fontSize: 23.0),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15.0),
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
                                              widget.user.userId!,currentLanguage);
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
