import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/input/category_input_screen.dart';
import 'package:radish_app/input/input_screen.dart';
import 'package:radish_app/screens/chat/chatroom_screen.dart';
import 'package:radish_app/screens/home_screen.dart';
import 'package:radish_app/screens/item/item_detail_screen.dart';
import 'package:radish_app/states/category_notifier.dart';
import 'package:radish_app/states/select_image_notifier.dart';

const LOCATIN_HOME = 'home';
const LOCATIN_INPUT = 'input';
const LOCATIN_CATEGORY_INPUT = 'category_input';
const LOCATION_ITEM = 'item';
const LOCATION_ITEM_ID = 'item_id';
const LOCATION_CHATROOM_ID = 'chatroom_id';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey(LOCATIN_HOME))];
  }

  @override
  List get pathBlueprints => ['/'];
}

class InputLocation extends BeamLocation {
  @override
  Widget builder(BuildContext context, Widget navigator) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: categoryNotifier),
        ChangeNotifierProvider(create: (context) => SelectImageNotifier())
      ],
      child: super.builder(context, navigator),
    );
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains(LOCATIN_INPUT))
        BeamPage(child: InputScreen(), key: ValueKey(LOCATIN_INPUT)),
      if (state.pathBlueprintSegments.contains(LOCATIN_CATEGORY_INPUT))
        BeamPage(
            child: CategoryInputScreen(), key: ValueKey(LOCATIN_CATEGORY_INPUT))
    ];
  }

  @override
  List get pathBlueprints =>
      ['/$LOCATIN_INPUT', '/$LOCATIN_INPUT/$LOCATIN_CATEGORY_INPUT'];
}

class ItemLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathParameters.containsKey(LOCATION_ITEM_ID))
        BeamPage(
            key: ValueKey(LOCATION_ITEM_ID),
            child:
                ItemDetailScreen(state.pathParameters[LOCATION_ITEM_ID] ?? "")),
      if (state.pathParameters.containsKey(LOCATION_CHATROOM_ID))
        BeamPage(
            key: ValueKey(LOCATION_CHATROOM_ID),
            child: ChatroomScreen(
                chatroomKey: state.pathParameters[LOCATION_CHATROOM_ID] ?? "")),
    ];
  }

  @override
  List get pathBlueprints =>
      ['/$LOCATION_ITEM/:$LOCATION_ITEM_ID/:$LOCATION_CHATROOM_ID'];
}
