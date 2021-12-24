import 'package:heleapp/data/data_source/remote_data_source.dart';
import 'package:heleapp/data/network/error_handler.dart';
import 'package:heleapp/data/network/network_info.dart';
import 'package:heleapp/domain/model/model.dart';
import 'package:heleapp/data/request/request.dart';
import 'package:heleapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:heleapp/domain/repository/repository.dart';
import 'package:heleapp/data/mapper/mapper.dart';

class RepositoryImp extends Repository {
  RemoteDateSource _remoteDateSource;
  NetworkInfo _networkInfo;
  RepositoryImp(this._remoteDateSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDateSource.login(loginRequest);
        if (response.status == ApiInternalClass.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalClass.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
