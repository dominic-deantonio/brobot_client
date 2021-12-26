import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class Controller {
  ValueNotifier<String> status = ValueNotifier('stop');
  final Client client = Client();
  final Map<String, String> _stringMap = {'stop': 'Stopped', 'forward': 'Forward', 'left': 'Left', 'right': 'Right', 'backward' : 'Reverse'};

  final String domain = 'http://192.168.4.1:8000'; // While connected to Pi directly
  // final String domain = 'http://192.168.1.143:3000'; // While on PC and Pi on LAN
  // final String domain = 'http://10.0.2.2:3000'; // While on PC and pointing to Pi

  void goDir([String? d]) async {
    HapticFeedback.lightImpact();
    final start = DateTime.now().millisecondsSinceEpoch;

    d = d ?? 'stop';
    var uri = Uri.parse('$domain/move?dir=$d');
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

  String getLabel(String s) => _stringMap[s] ?? 'Error';
}
