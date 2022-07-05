import 'package:flutter/material.dart';
import 'package:radish_app/states/user_provider.dart';
import 'package:provider/provider.dart';

import 'home/items_page.dart';

//홈화면 클래스 생성(인스턴스)
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

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
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          ItemsPage(),
          Container(
            color: Colors.accents[4],
          ),
          Container(
            color: Colors.accents[10],
          ),
          Container(
            color: Colors.accents[15],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(_bottomSelectedIndex == 0
                  ? 'assets/icons/icon_home_select.png'
                  : 'assets/icons/icon_home_normal.png'),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(_bottomSelectedIndex == 1
                  ? 'assets/icons/icon_location_select.png'
                  : 'assets/icons/icon_location_normal.png'),
            ),
            label: '내근처',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(_bottomSelectedIndex == 2
                  ? 'assets/icons/icon_chat_select.png'
                  : 'assets/icons/icon_chat_normal.png'),
            ),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(_bottomSelectedIndex == 3
                  ? 'assets/icons/icon_info_select.png'
                  : 'assets/icons/icon_info_normal.png'),
            ),
            label: '내정보',
          ),
        ],
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
      ),
    );
  }
}
