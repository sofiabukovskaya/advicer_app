abstract class AdviceEvent {}

class AdviceRequestEvent extends AdviceEvent {
  final String param;

  AdviceRequestEvent({required this.param});
}
