part of 'chat_cubit.dart';

@immutable
abstract class ChatStates {}

final class ChatInitial extends ChatStates {}
final class ChatSuccess extends ChatStates {}
final class ChatUpdateText extends ChatStates {}

final class ChatSendMessageLoadingState extends ChatStates {}
final class ChatSendMessageSuccessState extends ChatStates {}
final class ChatSendMessageFailureState extends ChatStates {
  final String error;

  ChatSendMessageFailureState({required this.error});
}
