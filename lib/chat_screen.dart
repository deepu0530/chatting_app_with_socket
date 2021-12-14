import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({required this.name, required this.room});
  final String name;
  final String room;
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  TextEditingController _controller = TextEditingController();
  var channel;
  List<Map<String, dynamic>> messages = [];
  initChat() async {
    channel = IOWebSocketChannel.connect(Uri.parse(
        'ws://vps-d5b18cef.vps.ovh.net:2000/chat-room/${widget.name}/${widget.room}'));

    channel.stream.listen((message) {
      print(message);
      setState(() {
        messages.add(jsonDecode(message));
      });
      // channel.sink.add(_controller.text);
      // channel.sink.close(status.goingAway);
    });
  }

  void sendData() {
    if (_controller.text.trim().isNotEmpty) {
      channel.sink.add(jsonEncode({
        "message": _controller.text.trim(),
      }));
      _controller.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    initChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crazy Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 10,top: 20),
                itemCount: messages.length,
                // itemCount: 4,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment:
                        messages[index]["username"] == widget.name
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      Container(
                        // width: MediaQuery.of(context).size.width*1.0,
                        width: 250,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: messages[index]["username"] == widget.name
                                ? Colors.purple[300]
                                : Colors.purple[400],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                messages[index]["username"],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[200]),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                messages[index]["message"],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          )),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 65, bottom: 0,top: 10),
              padding: EdgeInsets.only(left: 15),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.purple,
              
              ),
              child: TextField(
              
                controller: _controller,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Type Message",
                  labelStyle: TextStyle(color: Colors.grey[200],fontWeight: FontWeight.w400,fontSize: 16)
                ),
              )
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0,top: 10),
        child: FloatingActionButton(
          
          child: Icon(Icons.send),
          onPressed: sendData,
        ),
      ),
    );
  }
}
