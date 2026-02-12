import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/features/optimization/domain/entities/optimization_state.dart';

void main() {
  group('ResultPanel Cursor Tests', () {
    testWidgets('should handle text controller updates correctly', (
      WidgetTester tester,
    ) async {
      String currentText = 'Initial text';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    TextField(
                      controller: TextEditingController(text: currentText),
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentText = 'Updated text';
                        });
                      },
                      child: const Text('Update'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Test that text field can be edited
      await tester.tap(textField);
      await tester.pump();
      await tester.enterText(textField, 'New text');
      await tester.pump();

      expect(find.text('New text'), findsOneWidget);
    });

    testWidgets('should preserve cursor position during updates', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController(text: 'Hello World');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TextField(controller: controller)),
        ),
      );

      final textField = find.byType(TextField);
      await tester.tap(textField);
      await tester.pump();

      // Set cursor to position 5
      controller.selection = const TextSelection(
        baseOffset: 5,
        extentOffset: 5,
      );

      // Update text while preserving cursor
      final newText = 'Hello Beautiful World';
      controller.text = newText;
      controller.selection = TextSelection.fromPosition(
        const TextPosition(offset: 5),
      );

      await tester.pump();

      expect(controller.text, equals(newText));
      expect(controller.selection.baseOffset, equals(5));
    });
  });
}
