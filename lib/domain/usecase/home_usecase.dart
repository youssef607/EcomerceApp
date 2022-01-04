import 'package:heleapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:heleapp/domain/model/model.dart';
import 'package:heleapp/domain/repository/repository.dart';
import 'package:heleapp/domain/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
