import 'package:dartz/dartz.dart';
import 'package:heleapp/data/network/failure.dart';
import 'package:heleapp/data/request/request.dart';
import 'package:heleapp/domain/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
