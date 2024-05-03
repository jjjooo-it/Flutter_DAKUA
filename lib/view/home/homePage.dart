import 'package:flutter/material.dart';

void main() {
  runApp(NavigationBarApp());
}

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MaterialApp(
      theme: theme.copyWith(useMaterial3: true),
      home: Scaffold(
        body: Column(
          children: [
            CustomHeaderWithImage(), // 헤더 표시
            Expanded(
              child: IndexedStack(
                index: currentPageIndex,
                children: <Widget>[
                  // 페이지 1: 홈
                  HomePage(),

                  // 페이지 2: 알림
                  NotificationsPage(),

                  // 페이지 3: 메시지
                  MessagesPage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          backgroundColor: theme.backgroundColor,
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Badge(
                child: Image.asset(
                  "assets/icons/1.png",
                  width: 40.43,
                  height: 40.98,
                ),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                child: Image.asset(
                  "assets/icons/2.png",
                  width: 40.43,
                  height: 40.98,
                ),
              ),
              label: '알림',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                child: Image.asset(
                  "assets/icons/3.png",
                  width: 40.43,
                  height: 40.98,
                ),
              ),
              label: '메시지',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHeaderWithImage extends StatelessWidget {
  final double headerHeight = 150.0; // 헤더 컨테이너의 높이

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0), // 상단 여백 추가
      child: SizedBox(
        height: headerHeight,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/icons/4.png',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/top_logo.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'DAKUA',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '요약하는데는 약 2분 정도 시간이 걸릴 수 있어요!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // 요약 생성 기능 추가
              },
              child: Container(
                width: 325,
                height: 50.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/buttom.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    '요약 생성하기',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
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

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('알림 페이지'),
    );
  }
}

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('메시지 페이지'),
    );
  }
}

class Badge extends StatelessWidget {
  final Widget child;

  Badge({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
          constraints: BoxConstraints(
            minWidth: 12,
            minHeight: 12,
          ),
        ),
      ],
    );
  }
}
