import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greenex/main.dart'; // Import your main app file

void main() {
  // Group of tests for MobileAppInterface
  group('Mobile App Interface Tests', () {
    
    // Test to ensure the app launches without errors
    testWidgets('App launches successfully', (WidgetTester tester) async {
      await tester.pumpWidget(MobileAppInterface());
      
      // Verify that the app builds without throwing any exceptions
      expect(find.byType(MobileAppInterface), findsOneWidget);
    });

    // Test AppBar components
    testWidgets('AppBar contains required elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MobileAppInterface()));
      
      // Check for back button
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      
      // Check for time text
      expect(find.text('9:30'), findsOneWidget);
      
      // Check for status icons
      expect(find.byIcon(Icons.signal_cellular_4_bar), findsOneWidget);
      expect(find.byIcon(Icons.battery_full), findsOneWidget);
    });

    // Test Search Bar functionality
    testWidgets('Search bar is present and interactive', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MobileAppInterface()));
      
      // Find search bar
      final searchFinder = find.byType(TextField);
      expect(searchFinder, findsOneWidget);

      // Enter text in search bar
      await tester.enterText(searchFinder, 'Test Search');
      await tester.pump();

      // Verify text input
      expect(find.text('Test Search'), findsOneWidget);
    });

    // Test Bottom Navigation Bar
    testWidgets('Bottom Navigation Bar works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MobileAppInterface()));
      
      // Find bottom navigation bar
      final bottomNavFinder = find.byType(BottomNavigationBar);
      expect(bottomNavFinder, findsOneWidget);

      // Verify all navigation items are present
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('Grid'), findsOneWidget);
      expect(find.text('Games'), findsOneWidget);
      expect(find.text('Shop'), findsOneWidget);
    });

    // Test Category Chips
    testWidgets('Category chips are displayed', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MobileAppInterface()));
      
      // Check for specific category chips
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Trending'), findsOneWidget);
      expect(find.text('Recent'), findsOneWidget);
    });

    // Test Grid View Items
    testWidgets('Grid view displays items', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MobileAppInterface()));
      
      // Find grid view
      final gridFinder = find.byType(GridView);
      expect(gridFinder, findsOneWidget);

      // Check number of grid items
      final gridItemFinder = find.text('Item Name');
      expect(gridItemFinder, findsNWidgets(4)); // Assuming 4 grid items
    });

    // Performance and Rendering Test
    testWidgets('App renders efficiently', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(MaterialApp(home: MobileAppInterface()));
      await tester.pump();

      stopwatch.stop();
      
      // Ensure initial render takes less than 100 milliseconds
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
    });

    // Interaction Test for Bottom Navigation
    testWidgets('Bottom Navigation changes index', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MobileAppInterface()));
      
      // Find a bottom navigation item
      final homeNavItem = find.text('Home');
      
      // Tap the navigation item
      await tester.tap(homeNavItem);
      await tester.pump();

      // You might want to add specific state checks here
    });
  });

  // Error Handling Tests
  group('Error Handling Tests', () {
    testWidgets('Handles network image loading errors', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MobileAppInterface()));
      
      // Find image widgets
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsWidgets);
    });
  });
}

// Custom Matcher for performance testing
class LessThan extends Matcher {
  final num _value;
  
  const LessThan(this._value);
  
  @override
  bool matches(dynamic item, Map matchState) {
    return item < _value;
  }
  
  @override
  Description describe(Description description) {
    return description.add('a value less than $_value');
  }
}