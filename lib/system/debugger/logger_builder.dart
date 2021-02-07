import 'package:fullstackdiv_material/system/config/env_types.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
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

    if (_environment.getCurrentEnv == EnvTypes.dev) {
      loggerDev.d('$easySearchTag$tag $print');
    } else if (_environment.getCurrentEnv == EnvTypes.qa ||
        _environment.getCurrentEnv == EnvTypes.uat) {
      loggerQA.d('$easySearchTag$tag $print');
    }
  }

  void printInfo(String print) {
    final String easySearchTag = easySearch ? defaultEasySearchTag : '';

    if (_environment.getCurrentEnv == EnvTypes.dev) {
      loggerDev.i('$easySearchTag$tag $print');
    } else if (_environment.getCurrentEnv == EnvTypes.qa ||
        _environment.getCurrentEnv == EnvTypes.uat) {
      loggerQA.i('$easySearchTag$tag $print');
    }
  }
}
