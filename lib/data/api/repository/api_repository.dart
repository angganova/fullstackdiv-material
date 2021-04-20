import 'package:fullstackdiv_material/data/api/client/api_client.dart';
import 'package:fullstackdiv_material/data/api/response/global_response.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class ApiRepository {
  ApiRepository._();

  static ApiRepository instance = ApiRepository._();

  final ApiClient apiClient = ApiClient.instance;

  /// App state
  /// Check Version
  Future<GlobalApiResponse> getVersion(int version) async {
    // final Map<String, dynamic> requestBody = <String, dynamic>{'version': version};
    //
    // return await apiClient
    //     .post('user/login', requestBody: requestBody)
    //     .then((Map<String, dynamic> value) => GlobalResponse.fromJson(value));

    return Future<GlobalApiResponse>.delayed(kDuration2s, () => GlobalApiResponse());
  }

  Future<GlobalApiResponse> userLogin(String phone) async {
    final Map<String, dynamic> requestBody = <String, dynamic>{'no_hp': phone};

    return await apiClient
        .post('user/login', requestBody: requestBody)
        .then((Map<String, dynamic> value) => GlobalApiResponse.fromJson(value));
  }
}
