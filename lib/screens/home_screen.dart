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
        title: Text('삼평동', style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}
