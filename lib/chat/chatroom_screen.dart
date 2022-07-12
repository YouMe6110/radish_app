import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:radish_app/data/chat_model.dart';
import 'package:radish_app/data/user_model.dart';
import 'package:radish_app/repo/chat_service.dart';
import 'package:radish_app/states/user_notifier.dart';

import 'chat.dart';

class ChatroomScreen extends StatefulWidget {
  final String chatroomKey;

  const ChatroomScreen({Key? key, required this.chatroomKey}) : super(key: key);

  @override
  _ChatroomScreenState createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        UserModel userModel = context.read<UserNotifier>().userModel!;
        Size _size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                MaterialBanner(
                  padding: EdgeInsets.only(bottom: 15),
                  leadingPadding: EdgeInsets.zero,
                  actions: [
                    Container(),
                  ],
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: ExtendedImage.network(
                          'https://picsum.photos/50',
                          fit: BoxFit.cover,
                        ),
                        contentPadding: EdgeInsets.only(
                          top: 10,
                          left: 16,
                        ),
                        dense: true,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: RichText(
                            text: TextSpan(
                              text: '거래완료',
                              style: Theme.of(context).textTheme.bodyText1,
                              children: [
                                TextSpan(
                                  text: '나이키 신발',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            text: '45,000원',
                            style: Theme.of(context).textTheme.bodyText1!
                              ..copyWith(color: Colors.black26),
                            children: [
                              TextSpan(
                                text: '가격제안불가',
                                style: Theme.of(context).textTheme.bodyText2!
                                  ..copyWith(color: Colors.black26),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: SizedBox(
                          height: 36,
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 18,
                            ),
                            label: Text(
                              '후기남기기',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 30,
                  color: Colors.yellow[100],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                        reverse: true,
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          bool isMine = (index % 2) == 0;
                          return Chat(
                            size: _size,
                            isMine: isMine,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: 25),
                  ),
                ),
                _buildInputBar(userModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputBar(UserModel userModel) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add, color: Colors.grey),
        ),
        Expanded(
          child: TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              isDense: true,
              hintText: '메세지를 입력하세요',
              filled: true,
              fillColor: Colors.white,
              suffixIcon: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.grey,
                ),
              ),
              suffixIconConstraints: BoxConstraints.tight(
                Size(40, 40),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            ChatModel chatModel = ChatModel(
                msg: _textEditingController.text,
                createdData: DateTime.now(),
                userKey: userModel.userKey);
            ChatService().createdNewChat(widget.chatroomKey, chatModel);

            _textEditingController.clear();
          },
          icon: Icon(
            Icons.send,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
