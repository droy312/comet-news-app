abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class GetFailure extends Failure {
  final String message;
  const GetFailure({required this.message}) : super(message: message);
}