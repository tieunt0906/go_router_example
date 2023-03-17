import 'package:flutter_test/flutter_test.dart';

class Counter {
  int value = 0;

  void increment() {
    value += 1;
  }

  void decrement() {
    value -= 1;
  }
}

void main() {
  group('Counter', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
