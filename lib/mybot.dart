import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {

  ChatUser myself=ChatUser(
   id: '1',firstName: "Srinath"
  );
  ChatUser bot=ChatUser(
   id: '2',firstName: "Gemini"
  );
  List<ChatMessage> messages=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(currentUser: myself,
       onSend: (ChatMessage message){
         print(message.toJson());
       },
       messages: messages,
         ),
    );
  }
}