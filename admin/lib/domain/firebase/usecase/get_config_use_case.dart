

import '../../../data/models/firebase/fb_config_response.dart';
import '../../../data/models/firebase/fb_error_response.dart';
import '../../../data/network/firebase_api.dart';
import '../../base_use_case.dart';
import '../../entities.dart';
import '../entities/app_config.dart';


class GetConfigUseCase implements BaseUseCase<AppConfig?, dynamic> {

  final FirebaseConfigApi _configApi = FirebaseConfigApi();
  @override
  Future<AppConfig?> call(_) async {
    final List<FBConfigResponse>  configList = await _configApi.getList();
    if (configList.isNotEmpty && configList.first is FBErrorResponse) {
      return null;
    }
    final AppConfig config = configList.map((e) => e.toEntity()).toList().first;
    return config;
  }

}