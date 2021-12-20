import 'package:get_it/get_it.dart';

import 'controller.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerSingleton<Controller>(Controller());
  print('Set up get_it');
}
