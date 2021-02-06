import 'package:fullstackdiv_material/rest/client/api_client.dart';
import 'package:fullstackdiv_material/rest/response_model/global_response.dart';

class RestRepo {
  ApiClient apiClient = ApiClient().getInstance();

  /// App state
  /// Check Version
  Future<GlobalResponse> userLogin(String phone) async {
    final Map<String, dynamic> requestBody = <String, dynamic>{'no_hp': phone};

    return await apiClient
        .post('user/login', requestBody: requestBody)
        .then((Map<String, dynamic> value) => GlobalResponse.fromJson(value));
  }
}
