import 'package:heleapp/data/network/app_api.dart';
import 'package:heleapp/data/request/request.dart';
import 'package:heleapp/data/responses/responses.dart';

abstract class RemoteDateSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDateSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.passWord,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }
}
