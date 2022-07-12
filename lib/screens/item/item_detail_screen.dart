import 'package:beamer/src/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/constants/common_size.dart';
import 'package:radish_app/data/chatroom_model.dart';
import 'package:radish_app/data/item_model.dart';
import 'package:radish_app/data/user_model.dart';
import 'package:radish_app/repo/chat_service.dart';
import 'package:radish_app/repo/item_service.dart';
import 'package:radish_app/router/locations.dart';
import 'package:radish_app/screens/item/similar_item.dart';
import 'package:radish_app/states/category_notifier.dart';
import 'package:radish_app/states/user_notifier.dart';
import 'package:radish_app/utils/time_calculation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemKey;

  const ItemDetailScreen(this.itemKey, {Key? key}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();

  bool isAppbarCollapsed = false;
  Size? _size;
  num? _statusBarHeight;

  get itemAddress => null;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_size == null || _statusBarHeight == null) return;
      if (isAppbarCollapsed) {
        if (_scrollController.offset <
            _size!.width - kToolbarHeight - _statusBarHeight!) {
          isAppbarCollapsed = false;
          setState(() {});
        }
      } else {
        if (_scrollController.offset >
            _size!.width - kToolbarHeight - _statusBarHeight!) {
          isAppbarCollapsed = true;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // todo: 채팅방 생성 및 이동 함수
  void _goToChatroom(ItemModel itemModel, UserModel userModel) async {
    //챗룸키 생성
    String chatroomKey =
    ChatroomModel.generateChatRoomKey(userModel.userKey, widget.itemKey);
    //챗룸 데이터 모델 생성
    ChatroomModel _chatroomModel = ChatroomModel(
        itemKey: itemModel.itemKey,
        itemTitle: itemModel.title,
        itemAddress: itemModel.address,
        itemPrice: itemModel.price,
        sellerKey: itemModel.userKey,
        buyerKey: userModel.userKey,
        sellerImage: "",
        buyerImage: "",
        geoFirePoint: itemModel.geoFirePoint,
        lastMsgTime: DateTime.now(),
        chatRoomKey: chatroomKey);
    //신규 챗룸 생성
    await ChatService().createNewChatroom(_chatroomModel);

    context.beamToNamed('/$LOCATION_ITEM/${widget.itemKey}/:${chatroomKey}');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemModel>(
      future: ItemService().getItem(widget.itemKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ItemModel itemModel = snapshot.data!; //아이템데이터 받기
          UserModel userModel =
          context
              .read<UserNotifier>()
              .userModel!; //유저데이터 받기
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _size = MediaQuery
                  .of(context)
                  .size;
              _statusBarHeight = MediaQuery
                  .of(context)
                  .padding
                  .top;
              return Stack(fit: StackFit.expand, children: [
              Scaffold(
              bottomNavigationBar: Container(
              height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(common_sm_padding),
                  child: SafeArea(
                    bottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                          children: [
                      IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                    VerticalDivider(
                        thickness: 1,
                        width: common_sm_padding,
                        indent: common_sm_padding,
                        endIndent: common_sm_padding),
                    SizedBox(
                      width: common_sm_padding,
                    ),

                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${itemModel.price}원',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1),
                      Text('가격 제안 불가',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2),
                    ],
                  ),
                  Expanded(child: Container()),
                  TextButton(
                    onPressed: () {
                      _goToChatroom(itemModel, userModel);
                    },
                    child: Text('채팅으로 거래하기'),
                  ),
                  ],
                ),
              ),
              ),
              ),
              ),
              body: CustomScrollView(
              controller: _scrollController,
              slivers: [
              _imageAppBar(itemModel, context),
              SliverList(
              delegate: SliverChildListDelegate(
              [
              _userSection(userModel),
              Divider(
              height: 1,
              thickness: 1,
              indent: common_bg_padding,
              endIndent: common_bg_padding),
              Padding(
              padding: const EdgeInsets.all(common_bg_padding),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(itemModel.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6),
              SizedBox(height: common_bg_padding),
              Text(
              '${categoriesMapEngToKor[itemModel.category] ?? "선택"}ㆍ${TimeCalculation.getTimeDiff(itemModel.createdDate)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
              decoration:
              TextDecoration.underline),
              ),
              SizedBox(height: common_bg_padding * 2),
              Text(itemModel.detail,
              style: TextStyle(
              fontSize: 15, color: Colors.black87)),
              SizedBox(height: common_bg_padding * 2),
              Text('채팅2ㆍ관심8ㆍ조회715'),
              ],
              ),
              ),
              Divider(
              height: 1,
              thickness: 1,
              indent: common_bg_padding,
              endIndent: common_bg_padding),
              MaterialButton(
              padding: EdgeInsets.all(common_bg_padding),
              onPressed: () {},
              child: Align(
              alignment: Alignment.centerLeft,
              child: Text('이 게시글 신고하기'),
              ),
              ),
              Divider(
              height: 1,
              thickness: 1,
              indent: common_bg_padding,
              endIndent: common_bg_padding),
              Padding(
              padding: const EdgeInsets.all(common_bg_padding),
              child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
              Text(
              '${userModel.phoneNumber.substring(9)} 님의 다른 판매상품',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1),
              SizedBox(
              width: 40,
              child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Text('더보기',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2),
              ),
              ),
              ],
              ),
              ),
              ],
              ),
              ),
              SliverToBoxAdapter(
              child: FutureBuilder<List<ItemModel>>(
              future: ItemService().getUserItems(
              userModel.userKey,
              itemKey: itemModel.itemKey),
              builder: (context, snapshot) {
              if (snapshot.hasData) {
              return Padding(
              padding:
              const EdgeInsets.all(common_sm_padding),
              child: GridView.count(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: common_sm_padding,
              crossAxisSpacing: common_sm_padding,
              childAspectRatio: 4 / 5,
              children: List.generate(
              snapshot.data!.length,
              (index) =>
              SimilarItem(snapshot.data![index])),
              ),
              );
              }
              return Container();
              }),
              ),
              ],
              ),
              ),
              Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: kToolbarHeight + _statusBarHeight!,
              child: Container(
              height: kToolbarHeight + _statusBarHeight!,
              decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
              Colors.black12,
              Colors.black12,
              Colors.black12,
              Colors.black12,
              Colors.transparent,
              ],
              )),
              ),
              ),
              Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: kToolbarHeight + _statusBarHeight!,
              child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor:
              isAppbarCollapsed ? Colors.white : Colors.transparent,
              foregroundColor:
              isAppbarCollapsed ? Colors.black87 : Colors.white,
              ),
              )
              ,
              )
              ,
              ]
              );
            },
          );
        }
        return Container();
      },
    );
  }

  SliverAppBar _imageAppBar(ItemModel itemModel, BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: _size!.width,
      flexibleSpace: FlexibleSpaceBar(
        title: SmoothPageIndicator(
            controller: _pageController, // PageController
            count: itemModel.imageDownloadUrls.length,
            effect: WormEffect(
                activeDotColor: Theme
                    .of(context)
                    .primaryColor,
                dotColor: Theme
                    .of(context)
                    .colorScheme
                    .background,
                radius: 2,
                dotHeight: 4,
                dotWidth: 4), // your preferred effect
            onDotClicked: (index) {}),
        centerTitle: true,
        background: PageView.builder(
          controller: _pageController,
          allowImplicitScrolling: true,
          itemBuilder: (BuildContext context, int index) {
            return ExtendedImage.network(
              itemModel.imageDownloadUrls[index],
              fit: BoxFit.cover,
              // scale: 0.1,
            );
          },
          itemCount: itemModel.imageDownloadUrls.length,
        ),
      ),
    );
  }

  Widget _userSection(UserModel userModel) {
    return Padding(
      padding: const EdgeInsets.all(common_bg_padding),
      child: Row(
        children: [
          ExtendedImage.network('https://picsum.photos/50',
              fit: BoxFit.cover,
              width: _size!.width / 10,
              height: _size!.height / 20,
              shape: BoxShape.circle),
          SizedBox(width: common_sm_padding),
          SizedBox(
            height: _size!.height / 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(userModel.phoneNumber.substring(9),
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1),
                Text(userModel.address,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2)
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '37.5 ℃',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: LinearProgressIndicator(
                              color: Colors.blueAccent,
                              value: 0.375,
                              minHeight: 4,
                              backgroundColor: Colors.grey[200]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: common_sm_padding),
                  Icon(Icons.face, color: Colors.blueAccent),
                ],
              ),
              SizedBox(height: common_sm_padding),
              Text(
                '매너온도',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}