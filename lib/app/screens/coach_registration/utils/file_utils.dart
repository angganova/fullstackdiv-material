import 'dart:convert';
import 'dart:io';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:image/image.dart' as im;
import 'package:path/path.dart' as p;

class FileUtils {
  final LoggerBuilder _loggerBuilder = LoggerBuilder('ImageUtils');

  Future<String> convertFileToBase64(String path, File file) async {
    if (file == null) {
      return null;
    } else {
      try {
        final File resizedFile = await resizeFile(path, file);
        final List<int> imageBytes = await resizedFile.readAsBytes();
        return base64Encode(imageBytes);
      } catch (e) {
        printDebug('_convertFileToBase64 error due to $e');
        return null;
      }
    }
  }

  Future<File> resizeFile(String path, File file) async {
    final int fileSize = await file.length();
    final int fileSizeInKb = (fileSize / 1000).ceil();
    printDebug('_resizeFile, file size = $fileSizeInKb KB');

    try {
      if (fileSizeInKb.isLessThan(500)) {
        printDebug('_resizeFile, resize not needed');
        if (getFileExt(path).ignoreCase('png')) {
          printDebug('_resizeFile, convert to png not needed');
          return file;
        } else {
          printDebug('_resizeFile, convert to png is needed for file $file');
          final im.Image rawImage = im.decodeImage(file.readAsBytesSync());
          return File('${getFilePath(path)}/${getFileName(path)}-resized.png')
            ..writeAsBytesSync(im.encodePng(rawImage));
        }
      } else {
        printDebug(
            '_resizeFile, resize needed and will convert to png for file $file');
        final im.Image rawImage = im.decodeImage(file.readAsBytesSync());
        final im.Image resizedImage = im.copyResize(rawImage, width: 512);
        return File('${getFilePath(path)}/${getFileName(path)}-resized.png')
          ..writeAsBytesSync(im.encodePng(resizedImage));
      }
    } catch (e) {
      printDebug('_resizeFile error due to $e');
      return null;
    }
  }

  String getFileName(String path) {
    if (path.isNullOrEmpty) {
      return null;
    } else {
      return path.split('/').last.replaceAll('.${getFileExt(path)}', '');
    }
  }

  String getFileExt(String path) {
    if (path.isNullOrEmpty) {
      return null;
    } else {
      return p.extension(path).replaceAll('.', '');
    }
  }

  String getFileNameAndExt(String path) {
    if (path.isNullOrEmpty) {
      return null;
    } else {
      return getFileName(path) + '.' + getFileExt(path);
    }
  }

  String getFilePath(String path) {
    if (path.isNullOrEmpty) {
      return null;
    } else {
      return path.replaceAll('/${getFileNameAndExt(path)}', '');
    }
  }

  bool validateImage(String path) {
    final String ext = getFileExt(path);
    return ext.ignoreCase('png') ||
        ext.ignoreCase('jpg') ||
        ext.ignoreCase('jpeg');
  }

  void printDebug(String print) => _loggerBuilder.printDebug(print);
}

enum imageExt { jpg, jpeg, png }
