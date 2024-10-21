import 'package:fcai_gpt/constants.dart';
import 'package:fcai_gpt/features/chat/presentation/views/chat.dart';
import 'package:flutter/material.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatScreen()));
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.chat_sharp,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Start Chat',
                      style: TextStyle(
                        fontFamily: 'Philosopher',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 36.0),
                child: Text(
                  'Ask the chatbot about your inquiries about bylaw, courses, how to calculate GPA, etc...',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Philosopher',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
