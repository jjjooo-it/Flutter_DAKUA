import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/home/loadingScreen.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: CarouselSlider(
                items: [
                  Center(child: Text('요약하는데 약 2분 정도 시간이 걸릴 수 있어요!', style: TextStyle(fontSize: 16.0),)),
                  Center(child: Text('DAKUA는 수업 요약에 탁월해요',  style: TextStyle(fontSize: 18.0),)),
                  Center(child: Text('광고문의 dakua@dankook.ac.kr',  style: TextStyle(fontSize: 18.0),)),
                ],
                options: CarouselOptions(
                  height: 50,
                  viewportFraction: 1, // 보여지는 배너의 너비 비율 설정
                  initialPage: 0,
                  enableInfiniteScroll: true, // 무한 스크롤 활성화
                  autoPlay: true, // 자동 재생 활성화
                  autoPlayInterval: Duration(seconds: 20), // 자동 재생 간격 설정
                  autoPlayAnimationDuration: Duration(milliseconds: 8000), // 자동 재생 애니메이션 지속 시간 설정
                  autoPlayCurve: Curves.fastOutSlowIn, // 자동 재생 애니메이션 커브 설정
                  scrollDirection: Axis.horizontal, // 스크롤 방향 설정
                ),
              ),
            ),
            SizedBox(height: 100.0),
            Text(
              '녹음 파일 첨부',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _attachFile(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: SizedBox(
                width: 230,
                height: 50,
                child: Center(
                  child: Text(
                    '첨부하기',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 150.0),
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
                    primary: Colors.transparent,
                    elevation: 0,
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
    );
  }
}

//파일 첨부 코드
void _attachFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile file = result.files.first;
    print('Selected file: ${file.name}');
  } else {
    print('File picking canceled.');
  }
}

void _navigateToLoadingPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoadingPage()),
  );
}
