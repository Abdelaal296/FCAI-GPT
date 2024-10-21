import 'package:fcai_gpt/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.only(top: 24, bottom: 24, right: 24, left: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  
                ),
                color: Color.fromARGB(255, 155, 192, 232),
              ),
              child: Text(
                message,
                textDirection: isRTL(message) ? TextDirection.rtl : TextDirection.ltr,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/user.jpg'),
          ),
        ],
      ),
    );
  }
}

class ChatBubbleForBot extends StatelessWidget {
  const ChatBubbleForBot({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/bot3.png'),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.only(top: 24, bottom: 24, right: 24, left: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: KPrimaryColor,
              ),
              child: Text(
                message,
                textDirection: isRTL(message) ? TextDirection.rtl : TextDirection.ltr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);
}
