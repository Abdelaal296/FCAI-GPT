import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fcai_gpt/constants.dart';
import 'package:fcai_gpt/core/utils/api_service.dart';
import 'package:fcai_gpt/core/utils/failures.dart';
import 'package:fcai_gpt/features/chat/data/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);
  List<MessageModel> messagesList = [];

  void addMessage({required String message, required int id}) {
    messagesList.add(MessageModel(message, id));
    emit(ChatSuccess());
  }

  String? text;
  void updateText(String newText) {
    text = newText;
    emit(ChatUpdateText());
  }

  void sendMessage({
    required String message,
  }) {
    emit(ChatSendMessageLoadingState());
    DioHelper.postData(
      url: '${baseUrl}query',
      data: {
        'query': message,
      },
    ).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
  
        addMessage(message: value.data['answer'].trimLeft(), id: 0);
      } else {
        emit(ChatSendMessageFailureState(error: ServerFailure.fromResponse(value.statusCode!).errorMessage));
      }
    }).catchError((error) {
      if (error is DioException) {
        emit(ChatSendMessageFailureState(error: ServerFailure.fromDioError(error).errorMessage));
      }else{

      emit(ChatSendMessageFailureState(error: error));
      }
    });
  }
}
