
import 'package:chat/constants.dart';
import 'package:chat/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    required this.message,
    super.key,
  });
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        padding: EdgeInsets.only(top: 25, bottom: 25, right: 16, left: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32)),
            color: KpraimaryColor),
      ),
    );
  }
}
