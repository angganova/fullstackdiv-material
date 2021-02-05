import 'package:fullstackdiv_material/system/config/env_types.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:logger/logger.dart';

class LoggerBuilder {
  LoggerBuilder(this.tag, {this.easySearch = true});

  final String tag;
  final bool easySearch;
  final String defaultEasySearchTag = 'XXX ';
  final Environments _environment = Environments();
  final Logger loggerDev =
      Logger(printer: PrettyPrinter(methodCount: 0));
  final Logger loggerQA =
      Logger(printer: PrettyPrinter(methodCount: 0));

  void printDebug(String print) {
    final String easySearchTag = easySearch ? defaultEasySearchTag : '';

    if (_environment.currentEnv == EnvTypes.dev) {
      loggerDev.d('$easySearchTag$tag $print');
    } else if (_environment.currentEnv == EnvTypes.qa ||
        _environment.currentEnv == EnvTypes.uat) {
      loggerQA.d('$easySearchTag$tag $print');
    }
  }

  void printInfo(String print) {
    final String easySearchTag = easySearch ? defaultEasySearchTag : '';

    if (_environment.currentEnv == EnvTypes.dev) {
      loggerDev.i('$easySearchTag$tag $print');
    } else if (_environment.currentEnv == EnvTypes.qa ||
        _environment.currentEnv == EnvTypes.uat) {
      loggerQA.i('$easySearchTag$tag $print');
    }
  }
}
