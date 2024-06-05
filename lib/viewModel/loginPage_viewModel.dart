import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileplatform_project/dbHelper/user_dbHelper.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:mobileplatform_project/view/front/middlePage.dart';

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
        _navigateToMiddlePage(context, user);
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
  void _navigateToMiddlePage(BuildContext context, User user) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1500),
        pageBuilder: (context, animation, secondaryAnimation) => MiddlePage(user: user),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = Curves.easeInOut;

          //화면 전환 애니메이션
          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animation,
            curve: Interval(0.0, 0.5, curve: curve), // 0부터 0.5까지는 흐려짐
          ));

          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
      ),
    );
  }

}
