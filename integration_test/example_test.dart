import 'package:flavored_patrol/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('counter state is the same after going to home and going back', (
    $,
  ) async {
    await $.pumpWidgetAndSettle(const MyApp());

    await $(FloatingActionButton).tap();
    expect($(#counterText).text, '1');

    await $.native.pressHome();
    await $.native.openApp();

    expect($(#counterText).text, '1');
    await $(FloatingActionButton).tap();
    expect($(#counterText).text, '2');

    await $.native.pressHome();
    await $.native.openApp();

    expect($(#counterText).text, '2');
  });
}
