import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

enum Dir { Stopped, Forward, Left, Right, Reverse }

class Controller {
  ValueNotifier<Dir> status = ValueNotifier(Dir.Stopped);
  final Client client = Client();

  // final String domain = 'http://raspberrypi:3000'; // While connected to Pi directly
  final String domain = 'http://192.168.1.143:3000'; // While on PC and Pi on LAN
  // final String domain = 'http://10.0.2.2:3000'; // While on PC and pointing to PC

  void goDir([Dir? d]) async {
    HapticFeedback.lightImpact();
    final start = DateTime.now().millisecondsSinceEpoch;

    d = d ?? Dir.Stopped;
    var uri = Uri.parse('$domain/go?d=${d.index}');
    try {
      final Response response = await client.get(uri).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        status.value = d;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      print('Caught error : $e');
    }
    print('Took ${DateTime.now().millisecondsSinceEpoch - start}ms');
  }
}
