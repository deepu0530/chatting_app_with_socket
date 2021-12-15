import 'package:flutter/material.dart';
import 'package:sockets/chat_screen.dart';
import 'package:sockets/utils/appcolors.dart';

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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Set UserName & RoomName"),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 50),
          child: Column(
            children: [
              // Icon(Icons.message,color: AppColors.appcolor,size: 120,),
              Container(
                height: 250,
                width: 350,
                child: Image.asset("assets/images/chatimg.png",fit: BoxFit.cover,)),
              SizedBox(height: 40,),
              Text("Welcome Back",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w500),),
              SizedBox(height: 40,),
              Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple[50],
                  ),
                  child: TextField(
                    controller: _usernamecontroller,
                    
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    cursorColor: AppColors.appcolor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "UserName",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 16)),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple[50],
                  ),
                  child: TextField(
                    controller: _roomcontroller,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    cursorColor: AppColors.appcolor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "RoomName",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 16)),
                  )),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (Context) => ChattingScreen(
                                  name: _usernamecontroller.text,
                                  room: _roomcontroller.text,
                                )));
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.appcolor,
                    ),
                    child: Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
