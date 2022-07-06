import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:radish_app/screens/home_screen.dart';

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
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains('input'))
        BeamPage(
            child: Scaffold(
              appBar: AppBar(
                title: Text('중고상품 올리기'),
                centerTitle: true,
              ),
              body: Container(
                color: Colors.lightBlue,
              ),
            ),
            key: ValueKey('input'))
    ];
  }

  @override
  List get pathBlueprints => ['/input'];
}
