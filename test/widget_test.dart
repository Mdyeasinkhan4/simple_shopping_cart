import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_shopping_cart/main.dart';

void main() {
  testWidgets('Shopping cart renders products and calculates cart summary',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ShoppingCartApp());

    // Verify products are listed
    expect(find.text('T-Shirt'), findsOneWidget);
    expect(find.text('Shoes'), findsOneWidget);
    expect(find.text('Watch'), findsOneWidget);
    expect(find.text('Bag'), findsOneWidget);

    // Initial cart summary checks
    expect(find.text('Total Items:'), findsOneWidget);

    // Add 1 Watch (Price: 2000)
    final addButtons = find.byIcon(Icons.add_circle_outline);
    await tester.tap(addButtons.at(2)); // Watch is 3rd product
    await tester.pump();

    // Verify Subtotal is ৳2000, no discount yet
    expect(find.text('৳2000'), findsWidgets);
    expect(find.text('-৳0'), findsOneWidget);

    // Add 1 Shoes (Price: 1500) -> Subtotal = 3500 >= 3000 -> 10% discount = 350, Grand Total = 3150
    await tester.tap(addButtons.at(1)); // Shoes is 2nd product
    await tester.pump();

    expect(find.text('৳3500'), findsOneWidget); // Subtotal
    expect(find.text('-৳350'), findsOneWidget); // Discount
    expect(find.text('৳3150'), findsOneWidget); // Grand Total
    expect(find.text('10% OFF Applied!'), findsOneWidget);
  });

  testWidgets('Search and Category Filter work together',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ShoppingCartApp());

    // Search "shirt"
    await tester.enterText(find.byType(TextField), 'shirt');
    await tester.pump();

    expect(find.text('T-Shirt'), findsOneWidget);
    expect(find.text('Shoes'), findsNothing);
    expect(find.text('Watch'), findsNothing);

    // Clear search
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    expect(find.text('Shoes'), findsOneWidget);

    // Select category "Accessories"
    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Accessories').last);
    await tester.pumpAndSettle();

    expect(find.text('Watch'), findsOneWidget);
    expect(find.text('T-Shirt'), findsNothing);
    expect(find.text('Shoes'), findsNothing);
  });
}
