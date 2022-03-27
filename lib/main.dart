import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double opa = 0;
  String txs = "Marcos esta hablando de los del desierto";
  int count = 1;
  Timer? _debounce;

  final myController = TextEditingController();

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 50), () {
      myController.text = txs.substring(0, count);
      myController.selection = TextSelection.fromPosition(
          TextPosition(offset: myController.text.length));
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage('assets/top.png')),
          Expanded(
              child: Stack(
            children: [
              Image(
                  image: AssetImage('assets/bg.png'),
                  fit: BoxFit.cover,
                  width: double.infinity),
              Column(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  AnimatedOpacity(
                    opacity: opa,
                    duration: const Duration(milliseconds: 200),
                    child: Image(image: AssetImage('assets/msg.png')),
                  )
                ],
              )
            ],
          )),
          Container(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 20.0 / 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 32,
                  color: Color(0xFF087949).withOpacity(0.08),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Icon(Icons.mic, color: Colors.blue),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0 * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.sentiment_satisfied_alt_outlined,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.74),
                          ),
                          SizedBox(width: 20.0 / 4),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              autocorrect: false,
                              enableSuggestions: false,
                              controller: myController,
                              onChanged: (te) {
                                myController.text = txs.substring(0, count);
                                myController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: myController.text.length));
                                count++;
                              },
                              decoration: InputDecoration(
                                hintText: "Escribe tu mensaje",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.64),
                          ),
                          SizedBox(width: 20.0 / 4),
                          IconButton(
                              onPressed: () => setState(() {
                                    myController.text = "Grabando...";
                                  }),
                              icon: Icon(
                                Icons.mic,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () => setState(() {
                            opa = 1;
                            myController.text = "";
                          }),
                      icon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
