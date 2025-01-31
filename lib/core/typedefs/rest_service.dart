import 'package:dartz/dartz.dart';
import 'package:app_management_system/core/services/failure.dart';

typedef RestServiceType<T> = Future<Either<Failure, T>>;
