import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/home/loadingScreen.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '요약하는데는 약 2분 정도 시간이 걸릴 수 있어요!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                '녹음 파일을 첨부해 주세요.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // 녹음 파일 첨부 기능 추가
                },
                child: Text('첨부하기'),
              ),
              SizedBox(height: 30.0),
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
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () => _navigateToLoadingPage(context),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // 버튼 배경 투명으로 설정
                      elevation: 0, // 그라디언트를 위한 elevation 설정
                    ),
                    child: Text(
                      '요약 생성하기',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void _navigateToLoadingPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoadingPage()),
  );
}