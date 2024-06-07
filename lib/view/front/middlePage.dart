import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../widget/bottomNavBar.dart';


class MiddlePage extends StatelessWidget {
  final User user;
  MiddlePage({required this.user});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '반갑습니다. ${user.username}님',
                style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 10),
              Text(
                '당신의 수업에 날개를 달아드릴게요',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 30),
              Image.asset(
                'assets/icons/logo.jpeg',
                width: 250,
                height: 250,
              ),
              SizedBox(height: 50),
              SizedBox(
                height: 60,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.greenAccent, Colors.blueGrey],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  child: ElevatedButton(
                    onPressed: () => _navigateToHomePage(context, user), // 녹음 파일 올리기 버튼 수정
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      "녹음 파일 올리기   >",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 60,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.greenAccent, Colors.blueGrey],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  child: ElevatedButton(
                    onPressed: () => _navigateToHistoryPage(context, user), // 지난 기록 보기 버튼 수정
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      "지난 기록 보기   >",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHomePage(BuildContext context, User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar(user: user, initialIndex: 1)), // homePage가 첫 번째 페이지이므로 initialIndex를 1로 설정
    );
  }

  void _navigateToHistoryPage(BuildContext context, User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar(user: user, initialIndex: 0)), // historyPage가 첫 번째 페이지이므로 initialIndex를 0으로 설정
    );
  }
}
