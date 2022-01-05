import 'package:dartz/dartz.dart';
import 'package:heleapp/data/network/failure.dart';
import 'package:heleapp/data/request/request.dart';
import 'package:heleapp/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);

  Future<Either<Failure, Authentication>> register(
      RegisterRequest loginRequest);

  Future<Either<Failure, HomeObject>> getHome();
  Future<Either<Failure, StoreDetails>> getStoreDetails();
}
