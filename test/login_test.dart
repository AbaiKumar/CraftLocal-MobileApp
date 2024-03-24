import 'package:flutter_test/flutter_test.dart';
import 'package:craftlocal/modal/modal.dart';

void main() {
  group('CraftLocalProvider Tests', () {
    test('contact Success', () async {
      // Arrange
      final provider = CraftLocalProvider();
      const String name = 'Logo';
      const String email = '';
      const String msg = '';

      // Act
      final result = await provider.contact(name, email, msg);

      // Assert
      expect(result, 'No');
    });

    test('contact Failure', () async {
      // Arrange
      final provider = CraftLocalProvider();
      const String name = 'Logo';
      const String email = 'abai@yahoo.com';
      const String msg = 'Hello';
      // Act
      final result = await provider.contact(name, email, msg);

      // Assert
      expect(result, 'Yes');
    });
  });
}
