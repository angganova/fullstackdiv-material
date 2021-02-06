import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> initializeInjection() async => $initGetIt(getIt);
