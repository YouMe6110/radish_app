import 'package:flutter/material.dart';
import 'package:radish_app/states/user_provider.dart';
import 'package:provider/provider.dart';

//홈화면 클래스 생성(인스턴스)
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈스크린'),
        actions: [
          IconButton(
            onPressed: (){
              context.read<UserProvider>().SetUserAuth(false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}