import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileplatform_project/dbHelper/user_dbHelper.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:mobileplatform_project/view/widget/bottomNavBar.dart';


class LoginViewModel extends ChangeNotifier {
  late User user;
  late BuildContext context;
  String usernameError = '';
  String passwordError = '';

  LoginViewModel(this.context) {
    user = User(id: '', username: '', password: '', country: '', userId: '');
  }

  void login() async {
    if (_validateInputs()) {
      User? loggedInUser =
      await DBHelper.getUser(user.username, user.password);
      if (loggedInUser != null) {
        user.userId = user.username; // 만약 로그인에 성공하면 userId를 할당
        _navigateToMainPage(context, user);
      } else {
        _showErrorDialog();
      }
    } else {
      notifyListeners();
    }
  }

  bool _validateInputs() {
    bool isValid = true;
    if (user.username.isEmpty) {
      usernameError = 'ID is required';
      isValid = false;
    } else {
      usernameError = '';
    }
    if (user.password.isEmpty) {
      passwordError = 'Password is required';
      isValid = false;
    } else {
      passwordError = '';
    }
    return isValid;
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('loginFailedTitle'.tr()),
          content: Text('loginFailedContent'.tr()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('confirmButtonText'.tr()),
            ),
          ],
        );
      },
    );
  }

  void _navigateToMainPage(BuildContext context, User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar(user: user)),
    );
  }
}
