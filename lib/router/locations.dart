import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/input/category_input_screen.dart';
import 'package:radish_app/input/input_screen.dart';
import 'package:radish_app/screens/home_screen.dart';
import 'package:radish_app/states/category_notifier.dart';
import 'package:radish_app/states/select_image_notifier.dart';


class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey('home'))];
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
          ChangeNotifierProvider(create: (context) => SelectImageNotifier()),
        ],
        child: super.builder(context, navigator)
    );
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if(state.pathBlueprintSegments.contains('input'))
        BeamPage(
            child: InputScreen(),
            key: ValueKey('input')
        ),
      if(state.pathBlueprintSegments.contains('category_input'))
        BeamPage(
            child: CategoryInputScreen(),
            key: ValueKey('category_input')
        )
    ];
  }

  @override
  List get pathBlueprints => ['/input', '/input/category_input'];
}