import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../model/user.dart';
import '../../viewModel/aiProcess_viewModel.dart';
import '../../dataSource/aiProcess_dataSource.dart';
import '../widget/appBar.dart';
import 'historySummaryPage.dart';

class HistoryDetailPage extends StatelessWidget {
  final String folder;
  final List<String> files;
  final User user;


  const HistoryDetailPage(
      {required this.folder, required this.files, Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentLanguage = context.locale.languageCode;
    print('current language $currentLanguage');
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 100),
                Text(
                  'pageTitle'.tr(),
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.0),
              color: Colors.grey[200],
              child: Text(
                "folderPrefix".tr() + folder,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: files.map((filePath) {
                List<String> parts = filePath.split('\\');
                String folderName = parts.length > 2 ? parts[2] : 'Unknown Date';
                String creationDate = parts.length > 2 ? parts[3] : 'Unknown Date';
                String fileName = parts.last;

                return Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.lightGreen[100],
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      var data = await getUserData(user.userId, folderName, creationDate, fileName,currentLanguage);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistorySummaryPage(user: user, data: data),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen[100],
                      elevation: 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              creationDate,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              fileName,
                              style: TextStyle(
                                fontSize: 23.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }


  Future<Map<String, String?>> getUserData(String? userId, String folderName, String date, String fileName, String currentLanguage) async {
    print("User ID: $userId, Folder Name: $folderName, Date: $date, File Name: $fileName, language: $currentLanguage");
    try {

      final uri = Uri.parse('http://220.149.250.118:8000/Get_User_text_data/folder/');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user_id': userId,
          'folder_name': folderName,
          'date': date,
          'file_name': fileName,
          'language': currentLanguage
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(utf8.decode(response.bodyBytes));

        // Assuming the response contains the image and summary text
        String? image = decodedResponse['image'];
        String? text_data = decodedResponse['text_data'];
        String? full_text_data = decodedResponse['full_text_data'];

        return {'image': image, 'text_data': text_data, 'full_text_data':full_text_data};
      } else {
        throw Exception('Failed to create folder');
      }
    } catch (e) {
      print('Error getUserData: $e');
      return {};
    }
  }
}
