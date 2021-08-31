abstract class Success {
  final String message;
  const Success({required this.message});
}

class GetSuccess extends Success {
  final String message;
  const GetSuccess({required this.message}) : super(message: message);
}