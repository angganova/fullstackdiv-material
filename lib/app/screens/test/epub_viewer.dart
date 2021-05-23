import 'dart:io';

import 'package:dio/dio.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class lorEpubViewerView extends StatefulWidget {
  @override
  _EpubViewerViewState createState() => _EpubViewerViewState();
}

class _EpubViewerViewState extends State<EpubViewerView> {
  final Dio dio = Dio();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> download() async {
    if (Platform.isIOS) {
      print('download');
      await downloadFile();
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: loading
              ? const CircularProgressIndicator()
              : FlatButton(
                  onPressed: () async {
                    final Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    print('$appDocDir');

                    // final String iosBookPath = '${appDocDir.path}/chair.epub';
                    // print(iosBookPath);
                    // final String androidBookPath =
                    //     'file:///android_asset/3.epub';

                    EpubViewer.setConfig(
                        themeColor: Theme.of(context).primaryColor,
                        identifier: 'iosBook',
                        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                        allowSharing: true,
                        enableTts: true,
                        nightMode: false);
                    // EpubViewer.open(
                    //   Platform.isAndroid ? androidBookPath : iosBookPath,
                    //   lastLocation: EpubLocator.fromJson(<String, dynamic>{
                    //     "bookId": "2239",
                    //     "href": "/OEBPS/ch06.xhtml",
                    //     "created": 1539934158390,
                    //     "locations": {
                    //       "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                    //     }
                    //   }),
                    // );

                    await EpubViewer.openAsset(
                      'assets/epub/4.epub',
                      lastLocation: EpubLocator.fromJson(<String, dynamic>{
                        "bookId": "2239",
                        "href": "/OEBPS/ch06.xhtml",
                        "created": 1539934158390,
                        "locations": {
                          "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                        }
                      }),
                    );
                    // get current locator
                    // EpubViewer.locatorStream.listen((locator) {
                    //   print(
                    //       'LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
                    // });
                  },
                  child: Container(
                    child: const Text('open epub'),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> downloadFile() async {
    print('download1');
    final PermissionStatus permission = await Permission.storage.status;

    if (permission != PermissionStatus.granted) {
      await Permission.storage.request();
    }

    startDownload();
  }

  Future<void> startDownload() async {
    final Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final String path = appDocDir.path + '/chair.epub';
    final File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        'https://github.com/FolioReader/FolioReaderKit/raw/master/Example/'
        'Shared/Sample%20eBooks/The%20Silver%20Chair.epub',
        path,
        deleteOnError: true,
        onReceiveProgress: (int receivedBytes, int totalBytes) {
          print((receivedBytes / totalBytes * 100).toStringAsFixed(0));
          //Check if download is complete and close the alert dialog
          if (receivedBytes == totalBytes) {
            loading = false;
            setState(() {});
          }
        },
      );
    } else {
      loading = false;
      setState(() {});
    }
  }
}
