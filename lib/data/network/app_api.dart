import 'package:dio/dio.dart';
import 'package:heleapp/app/constant.dart';
import 'package:heleapp/data/responses/responses.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("emei") String emei,
    @Field("device_type") String device_type,
  );
}
