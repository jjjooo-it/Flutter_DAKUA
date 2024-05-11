import 'package:flutter/material.dart';
import 'package:mobileplatform_project/dbHelper/user_dbHelper.dart';
import 'package:mobileplatform_project/model/user.dart';

class SignUpViewModel extends ChangeNotifier {
  late User user;
  late BuildContext context;

  SignUpViewModel(this.context) {
    user = User(id: '', username: '', password: '', name: '', country: ''); // 초기화
  }

  void signUp() async {
    try {

      if (user.username.isNotEmpty &&
          user.password.isNotEmpty &&
          user.id.isNotEmpty &&
          user.country.isNotEmpty) {

        await DBHelper.insertUser(user);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('축하합니다!'),
            content: Text('회원가입이 완료되었습니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('확인'),
              ),
            ],
          ),
        );
      } else {

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('오류'),
            content: Text('모든 필수 정보를 입력해주세요.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('확인'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('회원가입 중 오류가 발생했습니다: $e');
    }
  }
}
