import 'package:flutter/material.dart';
import 'package:mobileplatform_project/model/user.dart';

class SignUpViewModel with ChangeNotifier {
  User _user = User(name: '', id: '', password: '', country: '');

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  void signUp(BuildContext context) {
    // 가입 로직 구현
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('축하합니다!'),
        content: Text('DAKUA 회원이 되셨습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}
