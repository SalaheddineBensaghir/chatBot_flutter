import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//sk-proj-6IPTNKlsfwMmBXumGKupT3BlbkFJmOUj1tzKDNDixqWHRKOE
class ChatBotPage extends StatefulWidget {
  ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  List message = [
    {"message": "Hello", "type": "user"},
    {"message": "How can i help you", "type": "assistant"}
  ];

  TextEditingController questionController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Chat Bot",
          style: TextStyle(
            color: Theme.of(context).indicatorColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                controller: scrollController,
                itemCount: message.length,
                itemBuilder: (context, index) {
                  bool isUser = message[index]['type'] == 'user';
                  return Column(
                    children: [
                      ListTile(
                        trailing: isUser ? Icon(Icons.person) : null,
                        leading: !isUser ? Icon(Icons.support_agent) : null,
                        title: Row(
                          children: [
                            SizedBox(
                              width: isUser ? 100 : 0,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  message[index]['message'],
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                color: isUser
                                    ? Color.fromARGB(100, 0, 200, 0)
                                    : Colors.white,
                                padding: EdgeInsets.all(10),
                              ),
                            ),
                            SizedBox(
                              width: isUser ? 0 : 100,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: questionController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.visibility),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      String question = questionController.text;
                      var openAiUri =
                          Uri.https("api.openai.com", "v1/chat/completions");
                      Map<String, String> headers = {
                        "Content-Type": "application/json",
                        "Authorization":
                            "Bearer sk-proj-6IPTNKlsfwMmBXumGKupT3BlbkFJmOUj1tzKDNDixqWHRKOE"
                      };
                      var prompt = {
                        "model": "gpt-3.5-turbo",
                        "messages": [
                          {"role": "assistant", "content": question}
                        ],
                        "temperature": 0.7
                      };
                      // http
                      //     .post( openAiUri,
                      //         headers: headers, body: json.encode(prompt))
                      //     .then( (resp) {
                      //   var responseBody = resp.body;
                      //   var chatResponse = json.decode(responseBody);
                      //   String responseContent =
                      //       chatResponse['choices'][0]['message']['content'];
                      setState(() {
                        // message.add({
                        //   "message": question,
                        //   "type": "user",
                        // });
                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 100);
                        message.add({
                          "message": question,
                          "type": "assistant",
                        });
                        // });
                        //   }, onError: (err) {
                        //     print("----- Erreur ----");
                        //     print(err);
                      });
                    },
                    icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
