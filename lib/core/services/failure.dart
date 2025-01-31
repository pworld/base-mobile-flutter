abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});

  @override
  String toString() => errorMessage;
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errorMessage});
}

class InvalidClientFailure extends Failure {
  const InvalidClientFailure({required super.errorMessage});
}
