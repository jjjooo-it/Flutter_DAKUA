# 🌐 Front with FLUTTER


## MVVM 구조로 코드를 작성
* dataSource : 데이터를 가져오는 영역
* dbHelper : Sqlite 사용을 위한 DB 제어
* model : 데이터 설계
* view(front/history/home/setting/widget) : 사용자에게 보여지는 영역
* viewModel : view의 상태 관리
  
<br/><br/>
## SQLite를 통한 회원가입/로그인/로그아웃 구현 [SQLite](https://www.sqlite.org/)
<pre><code>
static Future<void> _initDatabaseFactory() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfiWeb;
  }

  static initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, username TEXT, password TEXT, name TEXT, country TEXT, userID TEXT)",
        );
      },
      version: 1,
    );
  }
</code></pre>

<br/><br/>
## 10초마다 넘겨지는 광고바
* carousel_slider 패키지 이용 [carousel_slider](https://pub.dev/packages/carousel_slider)
* 여러 옵션을 지정할 수 있음
<pre><code>
options: CarouselOptions(
        height: 400.0, // 슬라이더의 높이를 지정
        aspectRatio: 16 / 9, // 슬라이더의 종횡비를 지정
        initialPage: 0, // 처음에 표시될 슬라이드의 인덱스
        enableInfiniteScroll: true, // 무한 스크롤 활성화
        reverse: false, // 슬라이드 넘기는 방향 반전
        autoPlay: true, // 자동 재생 활성화
        autoPlayInterval: Duration(seconds: 3), // 자동 재생 간격
        autoPlayAnimationDuration: Duration(milliseconds: 800), // 자동 재생 애니메이션 시간
        autoPlayCurve: Curves.fastOutSlowIn, // 자동 재생 애니메이션 커브
        pauseAutoPlayOnTouch: true, // 사용자가 터치하면 자동 재생 일시 중지
        enlargeCenterPage: true, // 중앙 페이지를 크게 표시
        onPageChanged: (index, reason) { // 페이지가 변경될 때 실행할 함수
          print('Page changed: $index, Reason: $reason');
        },
        scrollDirection: Axis.horizontal, // 스크롤 방향을 가로로 설정
      ),
</code></pre>

<br/><br/>
## 아코디언 형식으로 요약 내용 보기
* isExpand 변수를 이용하여 버튼 클릭시 내용을 대치

<br/><br/>
## 언어 설정(한국어/중국어)
* easy_localization 패키지 이용 [flutter_localization](https://pub.dev/packages/easy_localization)

<br/><br/>
## 로딩 바 
* flutter_spinkit 패키지 이용 [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)
