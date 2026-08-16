/// abstract class are used to create concerte class
/// abstract interface are used to define a set of methods that a class must implement
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  /// Either is class To show failure or success
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
