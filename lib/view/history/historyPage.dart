import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:mobileplatform_project/view/history/historyDetailPage.dart';
import 'package:http/http.dart' as http;
import '../../model/user.dart';
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  final User user;
  const HistoryPage({Key? key, required this.user}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> folders = [];
  List<List<String>> files = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFolderAndFiles(widget.user);
  }

  Future<void> fetchFolderAndFiles(User user) async {
    try {
      final response = await http.post(
        Uri.parse('http://220.149.250.118:8000/Get_Folder_Name/?user_id=${user.userId}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        // Parse and extract folders and files
        List<String> fetchedFolders = [];
        List<List<String>> fetchedFiles = [];
        for (var entry in data) {
          if (entry['folder'] != null) {
            String folder = entry['folder'];
            List<String> fileList = List<String>.from(entry['files']);
            if (fileList.isNotEmpty) {
              fetchedFolders.add(folder);
              fetchedFiles.add(fileList);
            }
            else{
              fetchedFolders.add(folder);
              List<String> fileList= [];
              fetchedFiles.add(fileList);

            }
          }
        }

        setState(() {
          folders = fetchedFolders;
          files = fetchedFiles;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load folders and files');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching folders and files: $e');
    }
  }

  Future<void> createFolder(String folderName, User user) async {
    try {
      final response = await http.post(
        Uri.parse('http://220.149.250.118:8000/Create_Folder/'),
        body: jsonEncode(<String, String>{
          'user_id': user.userId.toString(),
          'folder_name': folderName,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          folders.add(folderName);
          files.add([]); // Adding an empty file list for the new folder
        });
      } else {
        throw Exception('Failed to create folder');
      }
    } catch (e) {
      print('Error creating folder: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Text(
                'past_records'.tr(),
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(
                thickness: 1.0,
                indent: 40.0,
                endIndent: 40.0,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _addFolder(context);
                      },
                      icon: Icon(
                        Icons.create_new_folder,
                        color: Colors.grey
                      ),
                      label: Text(
                        'new_folder'.tr(),
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.grey,
                        ),
                      ),
                    ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 5.0,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                children: List.generate(folders.length, (index) {
                  String folderName = folders[index];
                  List<String> folderFiles = files[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryDetailPage(
                            folder: folderName,
                            files: folderFiles,
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/file_image.png',
                          width: 70,
                          height: 70,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          folderName,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addFolder(BuildContext context) {
    String folderName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("add_new_folder".tr()),
          content: TextField(
            onChanged: (value) {
              folderName = value;
            },
            decoration: InputDecoration(hintText: "folder_name".tr()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (folderName.isNotEmpty) {
                  createFolder(folderName, widget.user);
                }
              },
              child: Text("confirm".tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("cancel".tr()),
            ),
          ],
        );
      },
    );
  }
}
