import 'package:easy_localization/easy_localization.dart';
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
              title: Text("saveRecordDialogTitle".tr()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("saveRecordFolderLabel".tr()),
                  isLoadingFolders
                      ? CircularProgressIndicator()
                      : DropdownButtonFormField<String>(
                    value: selectedFolder,
                    hint: Text("saveRecordFolderHint".tr()),
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
                  Text("saveRecordNameLabel".tr()),
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("saveSuccessMessage".tr())));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("saveFailedMessage".tr())));
                    }
                  },
                  child: Text("saveButtonText".tr()),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("cancelButtonText".tr()),
                ),
              ],
            );
          },
        );
      },
    );
  }



}
