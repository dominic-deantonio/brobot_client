import 'package:brobot_client/serviceLocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controller.dart';

void main() {
  setUpGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brobot',
      home: Home2(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home2 extends StatelessWidget {
  final Controller c = getIt<Controller>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: c.status,
      builder: (BuildContext context, String status, Widget? child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: SpeedController(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 80.0),
                  child: child,
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(c.getLabel(status)),
                ValueListenableBuilder(
                  valueListenable: c.devMode,
                  builder: (BuildContext context, bool isDevMode, Widget? child) {
                    return Text(
                      isDevMode ? 'DevMode' : '',
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: DPad(),
    );
  }
}

class SpeedController extends StatelessWidget {
  final Controller c = getIt<Controller>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: c.speed,
      builder: (BuildContext context, double speed, Widget? child) {
        return Container(
          width: 115,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black12),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft, child: Text('Speed: ${(speed * 100).round()}')),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: speed,
                      onChanged: (double value) => c.setSpeed(value),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DPad extends StatelessWidget {
  final Controller c = getIt<Controller>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DirButton(
              'forward',
              child: RotatedBox(quarterTurns: 1, child: Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.white)),
              color: Colors.amber,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DirButton(
                  'left',
                  child: RotatedBox(quarterTurns: 0, child: Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.white)),
                  color: Colors.blue,
                ),
                SizedBox(width: 0),
                DirButton(
                  'right',
                  child: RotatedBox(quarterTurns: 2, child: Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.white)),
                  color: Colors.purple,
                ),
              ],
            ),
            DirButton(
              'backward',
              child: RotatedBox(quarterTurns: 3, child: Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.white)),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class DirButton extends StatelessWidget {
  final String dir;
  final Widget child;
  final Color color;
  final Controller c = getIt<Controller>();

  DirButton(this.dir, {Key? key, required this.child, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      color: color,
      splashColor: Colors.transparent,
      shape: CircleBorder(),
      onPressed: () => {},
      child: GestureDetector(
        onTapDown: (d) => c.goDir(dir),
        onTapUp: (d) => c.goDir(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: child,
        ),
      ),
    );
  }
}
