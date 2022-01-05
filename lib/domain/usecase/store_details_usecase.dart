import 'package:dartz/dartz.dart';
import 'package:heleapp/data/network/failure.dart';
import 'package:heleapp/domain/model/model.dart';
import 'package:heleapp/domain/repository/repository.dart';

import 'base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return repository.getStoreDetails();
  }
}
