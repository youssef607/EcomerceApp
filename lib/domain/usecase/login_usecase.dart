import 'package:heleapp/app/functions.dart';
import 'package:heleapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:heleapp/data/request/request.dart';
import 'package:heleapp/domain/model/model.dart';
import 'package:heleapp/domain/repository/repository.dart';
import 'package:heleapp/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
        input.email, input.password, deviceInfo.identifier, deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
