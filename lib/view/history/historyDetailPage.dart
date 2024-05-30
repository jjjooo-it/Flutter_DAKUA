import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:http/http.dart' as http;
import '../../model/user.dart';


class HistoryDetailPage extends StatelessWidget {
  final String folder;
  final List<String> files;
  final User user;

  const HistoryDetailPage(
      {required this.folder, required this.files, Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  '지난 기록',
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
                "            전체    >    $folder",
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
                // Split the filePath to extract the date and the file name
                List<String> parts = filePath.split('\\');
                print(parts);
                String folderName =
                parts.length > 2 ? parts[2] : 'Unknown Date';
                String creationDate =
                parts.length > 2 ? parts[3] : 'Unknown Date';
                String fileName = parts.last;

                return Container(
                  height: 100,
                  // Increased height to accommodate both file name and creation date
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.lightGreen[100],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button's onPressed logic here
                      // call get user text data/folder api
                      getUserData(
                          user.userId, folderName, creationDate, fileName);
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


  Future<void> getUserData(String? user_id, String folder_name, String date,
      String file_name) async {
    print("getUserData api call ");
    print(
        "User ID: $user_id, Folder Name: $folder_name, Date: $date, File Name: $file_name");
    try {
      final uri = Uri.parse(
          'http://220.149.250.118:8000/Get_User_text_data/folder/');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user_id': user_id,
          'folder_name': folder_name,
          'date': date,
          'file_name': file_name,
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
        //print('Success: $decodedResponse');
      } else {
        throw Exception('Failed to create folder');
      }
    } catch (e) {
      print('Error getUserData: $e');
    }
  }
}