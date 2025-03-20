import 'package:flutter/services.dart';

class BulletFormatter extends TextInputFormatter {
  // static const String bullet = '•'; // Using a thicker bullet point
  // static const String bulletWithSpace = '• ';
  static const String bullet = '●'; // Using a thicker bullet point
  static const String bulletWithSpace = '● ';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value is empty, return with a bullet point
    if (newValue.text.isEmpty) {
      return TextEditingValue(
        text: bulletWithSpace,
        selection: TextSelection.collapsed(offset: bulletWithSpace.length),
      );
    }

    // Get the current text and selection
    String text = newValue.text;
    TextSelection selection = newValue.selection;

    // Split the text into lines
    List<String> lines = text.split('\n');

    // Process each line to ensure it starts with a bullet point
    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();
      if (!line.startsWith(bullet)) {
        lines[i] = '$bulletWithSpace$line';
      }
    }

    // Join the lines back together
    text = lines.join('\n');

    // Calculate new cursor position
    int newPosition = selection.baseOffset;
    if (selection.baseOffset > 0) {
      // Count how many bullet points were added before the cursor
      int currentLine =
          text.substring(0, selection.baseOffset).split('\n').length - 1;
      int bulletPointsBeforeCursor = currentLine;
      newPosition += bulletPointsBeforeCursor * bulletWithSpace.length;
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: newPosition),
    );
  }
}
