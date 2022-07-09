import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/constants/common_size.dart';
import 'package:radish_app/data/item_model.dart';
import 'package:radish_app/repo/item_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemModel>(
      future: ItemService().getItem(widget.itemKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ItemModel itemModel = snapshot.data!;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _size = MediaQuery.of(context).size;
              _statusBarHeight = MediaQuery.of(context).padding.top;
              return Stack(fit: StackFit.expand, children: [
                Scaffold(
                  body: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: _size!.width,
                        flexibleSpace: FlexibleSpaceBar(
                          title: SmoothPageIndicator(
                              controller: _pageController, // PageController
                              count: itemModel.imageDownloadUrls.length,
                              effect: WormEffect(
                                  activeDotColor:
                                      Theme.of(context).primaryColor,
                                  dotColor:
                                      Theme.of(context).colorScheme.background,
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
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            _userSection(),
                          ],
                        ),
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
                  ),
                ),
              ]);
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _userSection() {
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
                Text('스토리로더', style: Theme.of(context).textTheme.subtitle1),
                Text('강남구 논현동', style: Theme.of(context).textTheme.bodyText2)
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
                style: Theme.of(context)
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
