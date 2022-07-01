import 'package:flutter/material.dart';
import 'package:radish_app/screens/start/intro_page.dart';

// 비머가드 false 리턴화면
class AuthScreen extends StatelessWidget {
  // 페이지 컨트롤러 인스턴스
  PageController _pageController = PageController();

  AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          IntroPage(_pageController),
          Container(color: Colors.accents[2],),
          Container(color: Colors.accents[5],),
        ],
      ),
    );
  }
}