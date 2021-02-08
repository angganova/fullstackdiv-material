import 'package:fullstackdiv_material/system/config/env_types.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:logger/logger.dart';

class LoggerBuilder {
  LoggerBuilder(this.tag, {this.easySearch = true});

  final Environments _environment = getIt<Environments>();
  final Logger loggerDev = Logger(printer: PrettyPrinter(methodCount: 0));
  final Logger loggerQA = Logger(printer: PrettyPrinter(methodCount: 0));

  final String tag;
  final bool easySearch;
  final String defaultEasySearchTag = 'XXX ';

  void printDebug(String print) {
    final String easySearchTag = easySearch ? defaultEasySearchTag : '';
    final String currentEnv = _environment.getCurrentEnv;

    if (currentEnv.ignoreCase(EnvTypes.dev)) {
      loggerDev.d('$easySearchTag$tag $print');
    } else if (currentEnv.ignoreCase(EnvTypes.qa) ||
        currentEnv.ignoreCase(EnvTypes.uat)) {
      loggerQA.d('$easySearchTag$tag $print');
    }
  }
}
