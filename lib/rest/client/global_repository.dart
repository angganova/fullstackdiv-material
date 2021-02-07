import 'package:fullstackdiv_material/rest/client/default_api_client.dart';
import 'package:fullstackdiv_material/rest/response_model/global_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RestRepo {
  RestRepo(this.apiClient);

  final DefaultApiClient apiClient;

  /// App state
  /// Check Version
  Future<GlobalResponse> userLogin(String phone) async {
    final Map<String, dynamic> requestBody = <String, dynamic>{'no_hp': phone};

    return await apiClient
        .post('user/login', requestBody: requestBody)
        .then((Map<String, dynamic> value) => GlobalResponse.fromJson(value));
  }
}
