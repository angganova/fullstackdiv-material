import 'package:injectable/injectable.dart';

import 'copy.dart';

@module
abstract class CopyModule {
  @preResolve
  Future<Copy> get copy => Copy.create();
}
