import 'package:flutter/material.dart';

// 비머가드 false 리턴화면
class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(child: Text('로그인을 하십시요.')),
    );
  }
}
