import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// SignUpViewModel 클래스는 ChangeNotifier를 상속하고 필요한 속성과 메서드를 갖춰야 합니다.
class SignUpViewModel with ChangeNotifier {
  String _email = '';
  String _password = '';
  String _nickname = '';
  String _country = '';

  // Getters
  String get email => _email;
  String get password => _password;
  String get nickname => _nickname;
  String get country => _country;

  // Setters
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set nickname(String value) {
    _nickname = value;
    notifyListeners();
  }

  set country(String value) {
    _country = value;
    notifyListeners();
  }

  // 가입 메서드
  void signUp() {
    // 여기에 가입 로직을 구현합니다.
    // 예를 들어, 이메일과 비밀번호로 실제로 서버에 가입 요청을 보낼 수 있습니다.
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('회원가입')),
        body: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              onChanged: (value) => viewModel.email = value,
              decoration: InputDecoration(
                labelText: '이메일',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.password = value,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.nickname = value,
              decoration: InputDecoration(
                labelText: '닉네임',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.country = value,
              decoration: InputDecoration(
                labelText: '국가',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => viewModel.signUp(),
              child: Text('가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}
