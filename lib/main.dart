import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/router/locations.dart';
import 'package:radish_app/screens/start_screen.dart';
import 'package:radish_app/screens/splash_screen.dart';
import 'package:radish_app/states/user_provider.dart';

//비머 전역 선언
final _routerDelegate = BeamerDelegate(
    //비머가드
    guards: [
      BeamGuard(
          pathBlueprints: ['/'],
          check: (context, location) {
            return context.watch<UserProvider>().user != null;
          },
          showPage: BeamPage(child: StartScreen()))
    ],
    locationBuilder: BeamerLocationBuilder(
        beamLocations: [HomeLocation(), InputLocation()]));

//메인함수 빌드
void main() {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//마이앱 클래스 선언(정적위젯)
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    //퓨처 함수로 로딩구현
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 300), //페이드인아웃 효과
              child: _splashLodingWidget(snapshot));
        });
  }

  StatelessWidget _splashLodingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print('에러가 발생하였습니다.');
      return Text('Error');
    } //에러발생
    else if (snapshot.connectionState == ConnectionState.done) {
      return RadishApp();
    } //정상
    else {
      return SplashScreen();
    } //그외
  }
}

// 홈페이지 클래스 선언
class RadishApp extends StatelessWidget {
  const RadishApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
        theme: ThemeData(
          hintColor: Colors.grey[350],
          fontFamily: 'DoHyeon',
          primarySwatch: Colors.green,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                primary: Colors.white,
                minimumSize: Size(48, 48)),
          ),
          textTheme: TextTheme(
              headline5: TextStyle(fontFamily: 'DoHyeon'),
              subtitle1: TextStyle(fontSize: 17, color: Colors.black87),
              subtitle2: TextStyle(fontSize: 13, color: Colors.black38),
              button: TextStyle(color: Colors.white),
              bodyText2: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w300)),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700),
            elevation: 2,
            actionsIconTheme: IconThemeData(color: Colors.black),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.black87,
              unselectedItemColor: Colors.black38),
        ),
        debugShowCheckedModeBanner: false, //에뮬레이터 디버그 표시 삭제
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
