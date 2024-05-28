import 'package:flutter/material.dart';
import 'package:mobileplatform_project/model/saveSummary.dart';
import '../dataSource/saveSummary_dataSource.dart';

class SaveSummaryViewModel extends ChangeNotifier {
  final SaveSummaryDataSource dataSource;
  SaveSummary? saveSummary;
  List<Map<String, dynamic>> folderData = [];
  bool isLoadingFolders = true;

  SaveSummaryViewModel(this.dataSource);

  void setFolderName(String value) {
    saveSummary?.folderName = value;
    notifyListeners();
  }

  void setFileName(String value) {
    saveSummary?.fileName = value;
    notifyListeners();
  }

  Future<void> saveUserData(String userId) async {
    if (saveSummary!.folderName.isEmpty || saveSummary!.fileName.isEmpty) {
      throw Exception('Folder name and file name cannot be empty');
    }

    try {
      await dataSource.saveUserData(userId, saveSummary!.folderName, saveSummary!.fileName);
    } catch (e) {
      // Handle error
      throw Exception('Failed to save user data');
    }
  }

  Future<void> fetchFolders(String userId) async {
    try {
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("요약 기록을 저장하시겠습니까?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("저장 폴더 선택"),
              isLoadingFolders
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                child: Column(
                  children: folderData.map((folder) {
                    return ExpansionTile(
                      title: Text(folder['folder']),
                      children: (folder['files'] as List<dynamic>).map<Widget>((file) {
                        return ListTile(
                          title: Text(file.toString()),
                          onTap: () {
                            setFolderName(folder['folder']);
                          },
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              Text("저장 이름"),
              TextFormField(
                onChanged: (value) {
                  setFileName(value);
                },
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
  }
}
