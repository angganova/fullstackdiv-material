import 'package:fullstackdiv_material/data/api/client/api_client.dart';
import 'package:fullstackdiv_material/data/api/response/global_response.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiRepository {
  ApiRepository(this.apiClient);

  final ApiClient apiClient;

  /// App state
  /// Check Version
  Future<GlobalResponse> getVersion(int version) async {
    // final Map<String, dynamic> requestBody = <String, dynamic>{'version': version};
    //
    // return await apiClient
    //     .post('user/login', requestBody: requestBody)
    //     .then((Map<String, dynamic> value) => GlobalResponse.fromJson(value));
    
    return Future<GlobalResponse>.delayed(kDuration2s, () => GlobalResponse());
  }

  Future<GlobalResponse> userLogin(String phone) async {
    final Map<String, dynamic> requestBody = <String, dynamic>{'no_hp': phone};

    return await apiClient
        .post('user/login', requestBody: requestBody)
        .then((Map<String, dynamic> value) => GlobalResponse.fromJson(value));
  }
}
