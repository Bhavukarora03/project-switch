import 'dart:math';

abstract class Helpers {
  static String randomURL() {
    final randomInt = Random().nextInt(100);
    return "https://picsum.photos/seed/$randomInt/200/200";
  }

  static DateTime randomDate() {
    final random = Random();
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }
}
