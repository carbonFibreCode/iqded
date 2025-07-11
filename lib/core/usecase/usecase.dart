import 'package:fpdart/fpdart.dart';
import 'package:iqded/core/error/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}