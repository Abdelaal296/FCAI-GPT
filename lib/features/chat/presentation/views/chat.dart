import 'package:auto_direction/auto_direction.dart';
import 'package:fcai_gpt/constants.dart';
import 'package:fcai_gpt/core/widgets/custom_flutter_toast.dart';
import 'package:fcai_gpt/features/chat/presentation/view_models/cubit/chat_cubit.dart';
import 'package:fcai_gpt/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {
          if (state is ChatSuccess || state is ChatSendMessageSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            });
          }
          if (state is ChatSendMessageFailureState) {
             showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: KPrimaryColor,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'FCAI-GPT',
                    style: TextStyle(
                      fontFamily: 'Philosopher',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: ChatCubit.get(context).messagesList.length,
                    itemBuilder: (context, index) {
                      var message = ChatCubit.get(context).messagesList[index];
                      return message.id == 0
                          ? ChatBubbleForBot(message: message.message)
                          : ChatBubble(message: message.message);
                    },
                  ),
                ),
                if (state is ChatSendMessageLoadingState)
                  LinearProgressIndicator(color: Colors.black),
                Container(
                  color: KPrimaryColor,
                  padding: const EdgeInsets.all(16.0),
                  child: AutoDirection(
                    text: ChatCubit.get(context).text ?? "",
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        ChatCubit.get(context).updateText(value);
                      },
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          ChatCubit.get(context).addMessage(message: value, id: 1);
                          controller.clear();
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                          FocusManager.instance.primaryFocus?.unfocus();
                          ChatCubit.get(context).sendMessage(message: value);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        hintStyle: const TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            var message = controller.text;
                            if (message.isNotEmpty) {
                              ChatCubit.get(context).addMessage(message: message, id: 1);
                              controller.clear();
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                              FocusManager.instance.primaryFocus?.unfocus();
                              ChatCubit.get(context).sendMessage(message: message);
                            }
                          },
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
