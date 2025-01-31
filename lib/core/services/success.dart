abstract class Success {
  final String successMessage;
  const Success({required this.successMessage});
}

class ServerSuccess extends Success {
  ServerSuccess({required super.successMessage});
}
