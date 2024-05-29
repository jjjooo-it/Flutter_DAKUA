import 'package:flutter/material.dart';
import 'package:mobileplatform_project/model/saveSummary.dart';
import '../dataSource/saveSummary_dataSource.dart';

class SaveSummaryViewModel extends ChangeNotifier {
  final SaveSummaryDataSource dataSource;
  SaveSummary? saveSummary = SaveSummary(folderName: '', fileName: '');
  List<Map<String, dynamic>> folderData = [];
  bool isLoadingFolders = true;

  SaveSummaryViewModel(this.dataSource);



  Future<void> saveUserData(String userId) async {
    print("call saveUserData function");
    print(saveSummary?.folderName);
    print(saveSummary?.fileName);

    if (saveSummary!.folderName.isEmpty || saveSummary!.fileName.isEmpty) {
      throw Exception('Folder name and file name cannot be empty');
    }

    try {
      print("save data api all");
      await dataSource.saveUserData(userId, saveSummary!.folderName, saveSummary!.fileName);
    } catch (e) {
      // Handle error
      throw Exception('Failed to save user data');
    }
  }

  Future<void> fetchFolders(String userId) async {
    try {
      print("fetchFolderData api call");
      isLoadingFolders = true;
      folderData = await dataSource.fetchFolderData(userId);
    } catch (e) {
      folderData = [];
    } finally {
      isLoadingFolders = false;
      notifyListeners();
    }
  }

  Future<void> showSaveRecordDialog(BuildContext context, String userId) async {
    await fetchFolders(userId);

    String? selectedFolder;
    bool isLoadingFolders = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("요약 기록을 저장하시겠습니까?"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("저장 폴더 선택"),
                  isLoadingFolders
                      ? CircularProgressIndicator()
                      : DropdownButtonFormField<String>(
                    value: selectedFolder,
                    hint: Text("폴더 선택"),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFolder = newValue;
                        print("selectedFolder $selectedFolder");
                        saveSummary?.folderName=selectedFolder!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    items: folderData.map<DropdownMenuItem<String>>((folder) {
                      return DropdownMenuItem<String>(
                        value: folder['folder'],
                        child: Text(folder['folder']),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Text("저장 이름"),
                  TextFormField(
                    onChanged: (value) {
                      print("setFileName $value");
                      saveSummary?.fileName=value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    try {
                      await saveUserData(userId);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("파일이 저장되었습니다.")));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("파일 저장에 실패했습니다.")));
                    }
                  },
                  child: Text("예"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("아니요"),
                ),
              ],
            );
          },
        );
      },
    );
  }



}
