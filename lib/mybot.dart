import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
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
  final headers={
    'Content-Type':'application/json'
  };
  List<ChatUser> typing=[];
  String? apiKey = dotenv.env['API_KEY'];
  var url='';
  getData(ChatMessage m) async{
    typing.add(bot);
    url='https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey';
    messages.insert(0,m);
    setState(() {
      
    });
     var data={"contents":[{"parts" :[{"text":m.text}]}]};
    await http.post(Uri.parse(url),
    headers:headers,
    body: jsonEncode(data)
    ).then((value) {
      if(value.statusCode==200){
        var result=jsonDecode(value.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);
      
        ChatMessage botMessage=ChatMessage(
          text: result['candidates'][0]['content']['parts'][0]['text'],
          user: bot,
          createdAt: DateTime.now(),

        );
        messages.insert(0,botMessage);
       
      }
      else{
        print("Some error occured");
      }
    }
    ).catchError((e){
      print(e);
    });
    typing.remove(bot);
     setState(() {
          
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Gemini",style: GoogleFonts.poppins(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white70),)),
        backgroundColor: Colors.black ,
      ),
      body: DashChat(
        typingUsers: typing,
        currentUser: myself,
       onSend: (ChatMessage message){
        getData(message);
       },
       messages: messages,
         ),
    );
  }
}