import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

const roundedCorner = Radius.circular(20);

class Chat extends StatelessWidget {
  final Size size;
  final bool isMine;

  const Chat({Key? key, required this.size, required this.isMine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMine ? _buildMyMsg(context) : _buildOthersMsg(context);
  }

  Row _buildOthersMsg(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ExtendedImage.network(
          'https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(6),
          shape: BoxShape.rectangle,
        ),
        SizedBox(
          width: 6,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text('나는 채팅 메세지입니다. 나는 채팅 메세지입니다.',
                  style: Theme.of(context).textTheme.bodyText1!),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              constraints:
                  BoxConstraints(minHeight: 40, maxWidth: size.width * 0.5),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topRight: roundedCorner,
                      topLeft: Radius.circular(2),
                      bottomRight: roundedCorner,
                      bottomLeft: roundedCorner)),
            ),
            SizedBox(
              width: 6,
            ),
            Text('오전 10:25'),
          ],
        ),
      ],
    );
  }

  Row _buildMyMsg(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('오전 10:25'),
        SizedBox(
          width: 6,
        ),
        Container(
          child: Text(
            '나는 채팅 메세지입니다. 나는 채팅 메세지입니다.',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          constraints:
              BoxConstraints(minHeight: 40, maxWidth: size.width * 0.6),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: roundedCorner,
                  topRight: Radius.circular(2),
                  bottomRight: roundedCorner,
                  bottomLeft: roundedCorner)),
        ),
      ],
    );
  }
}
