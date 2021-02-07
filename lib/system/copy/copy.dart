import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/system/copy/copy_item.dart';
import 'package:injectable/injectable.dart';

// TODO(Rollen): Move hardcoded values into environment
class Copy {
  Copy();

  factory Copy.fromJson(List<Map<String, dynamic>> json) {
    return Copy()..payloads = json;
  }

  List<Map<String, dynamic>> payloads;

  String locale = 'en';

  @factoryMethod
  static Future<Copy> create() async {
    final String jsonString =
        await rootBundle.loadString('assets/copy/copy.json');
    final String jsonAlphaString =
        await rootBundle.loadString('assets/copy/copy_alpha.json');
    final Map<String, dynamic> decodedJSON =
        jsonDecode(jsonString) as Map<String, dynamic>;
    final Map<String, dynamic> decodedAlphaJSON =
        jsonDecode(jsonAlphaString) as Map<String, dynamic>;

    // ignore: always_specify_types
    return Copy.fromJson([decodedJSON, decodedAlphaJSON]);
  }

  String missing(String copy) {
    // print('Missing copy $copy');
    return copy;
  }

  String get(String id) {
    String answer;

    /// Perform a cascade search to find the key in the latest file
    /// e.g Serch copy.json first then overwrite if found in copy_alpha.json
    for (final Map<String, dynamic> payload in payloads) {
      payload.forEach((String key, dynamic value) {
        // Get section where section is -> e.g general / notifications
        final Map<String, dynamic> section = value as Map<String, dynamic>;

        // Extract locale value if it is found in the section.
        if (section.containsKey(id)) {
          final CopyItem copyItem =
              CopyItem.fromJson(section[id] as Map<String, dynamic>);
          answer = copyItem?.en?.toString();
        }
      });
    }

    if (answer == null) {
      print('COPY: Unable to find copy $id');
    }
    answer ??= id;
    return answer;
  }
}
