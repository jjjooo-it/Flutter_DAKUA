import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/front/signupPage.dart';
import 'package:mobileplatform_project/view/home/homePage.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/logo.jpeg', // 이미지 파일 경로 설정
                  width: 50, // 이미지 너비 설정
                  height: 50, // 이미지 높이 설정
                ),
                SizedBox(width: 10),
                Text(
                  'DAKUA',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              // controller: _emailController,
              decoration: InputDecoration(
                labelText: 'ID',
                filled: true, // 배경색 채우기
                fillColor: Colors.grey[200], // 배경색 변경
                border: OutlineInputBorder( // 둥근 테두리
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              // controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true, // 배경색 채우기
                fillColor: Colors.grey[200], // 배경색 변경
                border: OutlineInputBorder( // 둥근 테두리
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // 버튼 너비를 화면 가로 전체로 확장
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // 버튼 색상 변경
                  padding: EdgeInsets.symmetric(vertical: 15.0), // 버튼 내부 패딩
                ),
                onPressed: () => _navigateToMainPage(context),
                child: Text(
                  '로그인하기',
                  style: TextStyle(fontSize: 18.0), // 폰트 크기 변경
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '아직 회원이 아니라면?',
                  style: TextStyle(fontSize: 14.0), // 폰트 크기 변경
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () => _navigateToSignUpPage(context),
                  child: Text(
                    '회원가입',
                    style: TextStyle(fontSize: 14.0), // 폰트 크기 변경
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToMainPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}

void _navigateToSignUpPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpPage()),
  );
}
