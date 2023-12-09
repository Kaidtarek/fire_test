import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List data = [];
    getData() async{
    QuerySnapshot recived = await FirebaseFirestore.instance.collection("categories").get();
    data.add(recived);
    }

    @override
    void initState() {
      print('data was get it');
      super.initState();
    }
getData();
    return MaterialApp(
        home: Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('add');
          },
          child: Icon(Icons.add)),
      appBar: AppBar(title: Text('welcoom'), actions: [
        IconButton(
            onPressed: () async {
              Navigator.of(context).pushReplacementNamed('login');
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout_outlined)),
        IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh))
      ]),
      body: GridView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(child: Image.asset('images/folder.png')),
                  Text('home'),
                ],
              ),
            ),
          );
        },
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    ));
  }
}
