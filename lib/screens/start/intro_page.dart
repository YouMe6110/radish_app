import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('무 마켓',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            ExtendedImage.asset('assets/images/intro_one.png'),
            Text('우리 동네 중고 직거래',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            Text('무마켓은 동네 직거래 마켓이에요.\n내 동네를 설정하고 시작해보세요!',
              style: TextStyle(fontSize: 13),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: (){},
                  child: Text('내 동네 설정하고 시작하기',
                    style: Theme.of(context).textTheme.button,
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}