import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:mobileplatform_project/view/front/loginPage.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late String selectedLanguage= 'koreanLanguage'.tr();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      selectedLanguage = context.locale.languageCode;
    });
  }

  // 로그아웃
  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'systemLanguageSetting'.tr(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              selectedLanguage = 'koreanLanguage'.tr();;
                              context.setLocale(Locale('ko', 'KR'));
                            });
                            Navigator.pop(context);
                          },
                          child: Text('koreanLanguage'.tr()),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              selectedLanguage = 'chineseLanguage'.tr();
                              context.setLocale(Locale('zh', 'CN'));
                            });
                            Navigator.pop(context);
                          },
                          child: Text('chineseLanguage'.tr()),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel'.tr()),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedLanguage.tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 1,
              color: Colors.grey[300],
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 20),
            CupertinoButton(
              onPressed: logout,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text('logout'.tr(),
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
