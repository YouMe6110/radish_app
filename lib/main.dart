import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/router/locations.dart';
import 'package:radish_app/screens/splash_screen.dart';
import 'screens/home_screen.dart';

//비머 전역 선언
final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
        beamLocations: [HomeLocation()]
    )
);

//메인함수 빌드
void main() {
  runApp(MyApp());
}

//마이앱 클래스 선언(정적위젯)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //퓨처 함수로 로딩구현
    return FutureBuilder<Object>(
        future: Future.delayed(Duration(seconds: 3), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 900),  //페이드인아웃 효과
            child: _splashLodingWidget(snapshot),   //스냅샷실행 위젯지정
          );
        }
    );
  }

  //스플래쉬로딩위젯 선언(인스턴스)
  StatelessWidget _splashLodingWidget(AsyncSnapshot<Object> snapshot) {
    if(snapshot.hasError) {print('에러가 발생하였습니다.'); return Text('Error');} //에러발생
    else if(snapshot.hasData) {return RadishApp();} //정상
    else{return SplashScreen();} //그외
  }

}

// 홈페이지 클래스 선언
class RadishApp extends StatelessWidget {
  const RadishApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,  //에뮬레이터 디버그 표시 삭제
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
    );
  }
}
