import 'package:flutter/material.dart';

import 'chat.bot.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        indicatorColor: Colors.white,
      ),
      routes: {"/chat": (context) => ChatBotPage()},
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Login Page",
            style: TextStyle(color: Theme.of(context).indicatorColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            height: 400,
            width: 400,
            color: Colors.black12,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("images/logo 3 (3).png")),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: loginController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String username = loginController.text;
                          String password = passwordController.text;
                          if (username == "admin" && password == "1234") {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "/chat");
                          }
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
