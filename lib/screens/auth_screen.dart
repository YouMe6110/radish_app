import 'package:flutter/material.dart';
import 'package:radish_app/screens/start/intro_page.dart';

// 비머가드 false 리턴화면
class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(children: [
        IntroPage(),
        Container(color: Colors.accents[2],),
        Container(color: Colors.accents[5],),
      ],
      ),
    );
  }
}