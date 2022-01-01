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

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await _remoteDateSource.forgotPassword(email);

        if (response.status == ApiInternalClass.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDateSource.register(registerRequest);
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

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDateSource.getHome();
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
