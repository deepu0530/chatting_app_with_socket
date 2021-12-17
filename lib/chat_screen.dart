import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sockets/utils/appcolors.dart';
import 'package:web_socket_channel/io.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({required this.name, required this.room});
  final String name;
  final String room;
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
   ScrollController _scrollController = ScrollController();
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
      Timer(
    Duration(seconds: 1),
    () => _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  duration: Duration(milliseconds: 30),
  curve: Curves.fastOutSlowIn,
  ),
  );
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 50, bottom: 25, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Crazy Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 25,
                )
              ],
            ),
          ),
        
          Expanded(
            child: Container(
              // margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(50),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                  color: Colors.white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height -10,
                    
                      child: ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            bottom: 10, top: 20, right: 20, left: 20),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Row(
                                      children: [
                                        Text(
                                          messages[index]["username"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[400]),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          messages[index]["created"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[400]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      // width: MediaQuery.of(context).size.width*1.0,
                                      width: 250,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 30),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: messages[index]
                                                    ["username"] ==
                                                widget.name
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40),
                                                bottomLeft: Radius.circular(40),
                                                bottomRight: Radius.circular(2))
                                            : BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40),
                                                bottomRight:
                                                    Radius.circular(40),
                                                bottomLeft: Radius.circular(2)),
                                        color: messages[index]["username"] ==
                                                widget.name
                                            ? Colors.deepPurple[100]
                                            : Colors.deepPurple[200],
                                      ),
                                      child: Text(
                                        messages[index]["message"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      )),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 70,
                      margin: const EdgeInsets.only(
                          right: 20, bottom: 20, top: 10, left: 20),
                      padding: EdgeInsets.only(left: 25,right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.deepPurple[50]
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.share,size: 20,color: Colors.grey,),
                          SizedBox(width: 20,),
                          Expanded(child: Container(child: TextField(
                            
                            controller: _controller,
                            cursorColor: AppColors.appcolor,
                            decoration: InputDecoration(
                              hintText: 'Type a Message.........',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400),
                              border: InputBorder.none
                            ),
                          ))),
                          GestureDetector(
      onTap: sendData,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: AppColors.appcolor),
                                  child: Center(child: Icon(Icons.send,color: Colors.white,),),
                            ),
                          ),
                        ],
                      )
                      // TextField(
                      //   controller: _controller,
                      //   style: TextStyle(color: Colors.white),
                      //   cursorColor: Colors.white,
                      //   decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       labelText: "Type Message",
                      //       labelStyle: TextStyle(
                      //           color: Colors.grey[200],
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 16)),
                      // )
                      ),
                ],
              ),
            ),
          )
        ],
      ),
      
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: Text("Crazy Chat"),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Expanded(
    //           child: ListView.separated(
    //             padding: EdgeInsets.only(bottom: 10,top: 20),
    //             itemCount: messages.length,
    //             // itemCount: 4,
    //             separatorBuilder: (BuildContext context, int index) =>
    //                 const SizedBox(
    //               height: 20,
    //             ),
    //             itemBuilder: (BuildContext context, int index) {
    //               return Row(
    //                 mainAxisAlignment:
    //                     messages[index]["username"] == widget.name
    //                         ? MainAxisAlignment.end
    //                         : MainAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     // width: MediaQuery.of(context).size.width*1.0,
    //                     width: 250,
    //                       padding: EdgeInsets.symmetric(
    //                           horizontal: 15, vertical: 15),
    //                       decoration: BoxDecoration(
    //                         shape: BoxShape.rectangle,
    //                         borderRadius: BorderRadius.circular(20),
    //                         color: messages[index]["username"] == widget.name
    //                             ? Colors.purple[300]
    //                             : Colors.purple[400],
    //                       ),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                            Text(
    //                             messages[index]["username"],
    //                             style: TextStyle(
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.w400,
    //                                 color: Colors.grey[200]),
    //                           ),
    //                           SizedBox(height: 10,),
    //                           Text(
    //                             messages[index]["message"],
    //                             style: TextStyle(
    //                                 fontSize: 16,
    //                                 fontWeight: FontWeight.w500,
    //                                 color: Colors.white),
    //                           )
    //                         ],
    //                       )),
    //                 ],
    //               );
    //             },
    //           ),
    //         ),
    // Container(
    //   margin: const EdgeInsets.only(right: 65, bottom: 0,top: 10),
    //   padding: EdgeInsets.only(left: 15),

    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(35),
    //     color: Colors.purple,

    //   ),
    //   child: TextField(

    //     controller: _controller,
    //     style: TextStyle(color: Colors.white),
    //     cursorColor: Colors.white,
    //     decoration: InputDecoration(
    //       border: InputBorder.none,
    //       labelText: "Type Message",
    //       labelStyle: TextStyle(color: Colors.grey[200],fontWeight: FontWeight.w400,fontSize: 16)
    //     ),
    //   )
    // ),
    //       ],
    //     ),
    //   ),
    // floatingActionButton: Padding(
    //   padding: const EdgeInsets.only(bottom: 0,top: 10),
    //   child: FloatingActionButton(

    //     child: Icon(Icons.send),
    //     onPressed: sendData,
    //   ),
    // ),
    // );
  }
}
