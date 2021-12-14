import 'package:flutter/material.dart';
import 'package:sockets/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
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
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _roomcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Set UserName & RoomName"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text("Set UserName & RoomName"),
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                height: 300,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purple),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      child: TextFormField(
                        autofocus: false,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: "Enter User Name",
                            labelStyle: TextStyle(color: Colors.grey[300]),
                            enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                            
                            ),
                        controller: _usernamecontroller,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      child: TextFormField(
                        cursorColor: Colors.white,
                        autofocus: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Enter Room Name",
                          labelStyle: TextStyle(color: Colors.grey[300]),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        controller: _roomcontroller,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "Set",
                          style: TextStyle(color: Colors.purple),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (Context) => ChattingScreen(
                                        name: _usernamecontroller.text,
                                        room: _roomcontroller.text,
                                      )));
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
