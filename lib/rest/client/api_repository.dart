import 'package:fullstackdiv_material/rest/client/api_client.dart';
import 'package:fullstackdiv_material/rest/response_model/global_response.dart';

class RestRepo {
  ApiClient apiClient = ApiClient().getInstance();

  /// App state
  /// Check Version
  Future<GlobalResponse> userLogin(phone) =>
      apiClient.globalPostCall("user/login", {"no_hp": phone});
}
