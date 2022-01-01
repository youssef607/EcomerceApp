import 'package:dartz/dartz.dart';
import 'package:heleapp/data/network/failure.dart';
import 'package:heleapp/domain/repository/repository.dart';
import 'package:heleapp/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }
}
