import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Users App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// Here we create a Future fn that will get data from server
  Future<List<User>> _getUsers() async {

  //store the response of the request in data
    var data = await http.get("http://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2");

  //now seperate the data using decode fn and passing the data body
    var jsonData = jsonDecode(data.body);

   //jsonData contains Array List so we can loop over it to get the data from it

    //create an array list
    List<User> users = [];

    for(var u in jsonData){

      //loop over to get each user object
      User user = User(u["index"],u["about"],u["name"],u["email"],u["picture"]);

      //add each use to the users array
      users.add(user);
    }

    print(users.length);

    return users;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        elevation: 10.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("User Details",textAlign: TextAlign.start,style: TextStyle(fontSize: 30.0),),
              decoration: BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topRight,
                 end: Alignment.bottomLeft,
                 colors: [Colors.purple, Colors.deepPurple]
               )
              )
            ),

            ListTile(
              leading: Icon(
                Icons.close
              ),
              title: Text("Close Icon"),
              subtitle: Text("Closes NavDrawer!"),
              selected: true,
              onTap: (){
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(
                Icons.face
              ),
              title: Text("Face Icon"),
              subtitle: Text("Its a Face icon!"),
              onTap: (){
                return true;
              },
            ),

            ListTile(
              leading: Icon(
                Icons.attach_file
              ),
               title: Text("Attach Icon"),
               subtitle: Text("Its an Attach icon!"),
                onTap: (){
                return true;
              },
            ),

            ListTile(
              leading: Icon(
                Icons.audiotrack
              ),
               title: Text("Audio Icon"),
               subtitle: Text("Its a Audio icon!"),
                onTap: (){
                return true;
              },
            ),

            ListTile(

              leading: Icon(
                Icons.backup
              ),
               title: Text("Backup Icon"),
               subtitle: Text("Its a BackUp icon!"),
                onTap: (){
                return true;
              },
            ),

          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: new Text(widget.title),
      ),
    body: Container(
        child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){

    if(snapshot.data == null){
    return Container(
    child: Center(
    child: Text("Loading..."),
    ),
    );
    }
    else{
    return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index){

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          snapshot.data[index].picture
        ),
      ),
    title: Text(snapshot.data[index].name),
      subtitle: Text(snapshot.data[index].email),
      onTap: (){

        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
        );
      },
    );
    },
    );
    }
    },
    ),
    ),
    );
  }
}

class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.name+" Details"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15.0),
            child: Center(
              child: CircleAvatar(
                backgroundImage: 
                NetworkImage( user.picture),
                maxRadius: 80.0,
              ),
            ),
          ),

          Text(user.name,
          style: TextStyle(
            fontWeight: prefix0.FontWeight.w500,
            fontSize: 32.0
          )),

          Text(user.email,
          style: TextStyle(
            fontWeight: prefix0.FontWeight.w300,
            fontSize: 20.0
          )),

          Divider(
            color: Colors.black87,
          ),

          Container(
            margin: EdgeInsets.all(25.0),
            child: ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.deepPurpleAccent,
              ),
              title: Text(user.about,
              style: TextStyle(
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
              ),),
            ),
          )
          
          
          
        ],
      )
    );
  }
}


//Create a class of how our JSON data looks
class User{
  //define all the fields that we will receive from the Json
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  //Initialize the constructor for this fields
  User(this.index,this.about,this.name,this.email,this.picture);


}
