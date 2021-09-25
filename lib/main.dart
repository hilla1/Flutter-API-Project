// Flutter application calling api from http//jsonplaceholder.typicode.com/users
// Displays first five names 
// body and title are centered
// Author kipkirui Hillary
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

// importing necessary modules

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'List of first 5 Names'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   Future getUserData() async{               // Quering data from the api
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com','users'));
    var jsonRsesults = jsonDecode(response.body);
    List<User> users = [];
  for(var u in jsonRsesults){
    User user= User(u["id"],u["name"],u["username"],u["email"],u["phone"],u["website"]);
    users.add(user);
  }
  return users;
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        ),
        body: Center(     // Centering all the body content
        child:Card(child: FutureBuilder(future:getUserData(), 
        builder:(BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==null){
            return Text("Loading....");
           } else{
            return ListView.builder(itemCount:5,
            itemBuilder: (BuildContext context,int id){
            return ListTile(
              leading: CircleAvatar(backgroundColor:Colors.deepPurple),
              title:Text(snapshot.data[id].name),
              subtitle:Text(snapshot.data[id].username),
              trailing:Text(snapshot.data[id].email),
              onTap:(){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder:(context)=> UserPage()),
                );
              },
            );
          },
        );
       }
     },
   ),
  ),
 ),
);
}
}

//datatype declaration
class User{
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  
// Constructor for Class User
  User(this.id,this.name,this.username, this.email, this.phone, this.website);
}

// Onclick page with title welcome

class UserPage extends StatelessWidget{
 @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('Welcome'),
         centerTitle: true,
      )
    );
  }
}