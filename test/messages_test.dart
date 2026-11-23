import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('goodMessage is displayed at the top of GetMaterialApp', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        builder: (context, child) => AppMessageHost(
          key: appMessageHostKey,
          child: child ?? const SizedBox.shrink(),
        ),
        home: const Scaffold(body: SizedBox.shrink()),
      ),
    );

    goodMessage('Dépense créée avec succès');
    await tester.pump();

    expect(find.text('Dépense créée avec succès'), findsOneWidget);
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('top-app-message'))).dy,
      lessThan(100),
    );

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
