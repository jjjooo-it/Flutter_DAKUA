import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  bool _dataReceived = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: _loading
            ? Column(                   /////////////////////////////로딩 화면 시작
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '요약 생성 중입니다. \n 잠시만 기다려 주세요.',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            SpinKitWave(
               itemBuilder: (context, index) {
                return const DecoratedBox(
                 decoration: BoxDecoration(color: Colors.green),
                );
              },
            ),
           ]
          )
            : _dataReceived          /////////////////////////////요약 결과 화면 시작
            ? Text(
          '끝~',
          style: TextStyle(fontSize: 20.0),
        )

            : Column(              /////////////////////////////기본 홈 화면 시작
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: CarouselSlider(
                items: [
                  Center(
                      child: Text(
                        '요약하는데 약 2분 정도 시간이 걸릴 수 있어요!',
                        style: TextStyle(fontSize: 16.0),
                      )),
                  Center(
                      child: Text(
                        'DAKUA는 수업 요약에 탁월해요',
                        style: TextStyle(fontSize: 18.0),
                      )),
                  Center(
                      child: Text(
                        '광고문의 dakua@dankook.ac.kr',
                        style: TextStyle(fontSize: 18.0),
                      )),
                ],
                options: CarouselOptions(
                  height: 50,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 20),
                  autoPlayAnimationDuration:
                  Duration(milliseconds: 8000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
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
                  onPressed: () {
                    setState(() {
                      _loading = true;
                      //백엔드로 부터 데이터를 가져왔는지 확인 하는 코드로 변경해야 함
                      Future.delayed(Duration(seconds: 5), () {
                        setState(() {
                          _dataReceived = true;
                          _loading = false;
                        });
                      });
                    });
                  },
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

  // 파일 첨부 코드
  void _attachFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      print('Selected file: ${file.name}');
    } else {
      print('File picking canceled.');
    }
  }
}