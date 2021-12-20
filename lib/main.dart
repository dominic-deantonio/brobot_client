import 'package:brobot_client/serviceLocator.dart';
import 'package:flutter/material.dart';
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
      home: Home(),
      theme: ThemeData.dark(),
    );
  }
}

class Home extends StatelessWidget {
  final Controller c = getIt<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ValueListenableBuilder(
                    valueListenable: c.status,
                    builder: (BuildContext context, Dir value, Widget? child) {
                      return Text(
                        value.name,
                        style: Theme.of(context).textTheme.headline3,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 110),
              DirButton(
                Dir.Forward,
                child: RotatedBox(quarterTurns: 1, child: Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.white)),
                color: Colors.amber,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DirButton(
                    Dir.Left,
                    child: RotatedBox(quarterTurns: 0, child: Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.white)),
                    color: Colors.blue,
                  ),
                  SizedBox(width: 60),
                  DirButton(
                    Dir.Right,
                    child: RotatedBox(quarterTurns: 2, child: Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.white)),
                    color: Colors.red,
                  ),
                ],
              ),
              DirButton(
                Dir.Reverse,
                child: RotatedBox(quarterTurns: 3, child: Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.white)),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DirButton extends StatelessWidget {
  final Dir dir;
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
          padding: const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }
}
