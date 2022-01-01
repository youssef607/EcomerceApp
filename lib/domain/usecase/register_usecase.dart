import 'package:heleapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:heleapp/data/request/request.dart';
import 'package:heleapp/domain/model/model.dart';
import 'package:heleapp/domain/repository/repository.dart';
import 'package:heleapp/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.countryMobileCode,
        input.userName,
        input.email,
        input.password,
        input.mobileNumber,
        input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String mobileNumber;
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String profilePicture;
  RegisterUseCaseInput(
    this.mobileNumber,
    this.countryMobileCode,
    this.userName,
    this.email,
    this.password,
    this.profilePicture,
  );
}
