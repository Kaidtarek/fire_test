import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase1/compenement/buttonField.dart';
import 'package:test_firebase1/compenement/textField.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<QueryDocumentSnapshot> dataList = [];
  TextEditingController nameController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    dataList.addAll(querySnapshot.docs);
    setState(() {});
  }

  Future<void> addUser() async {
    String name = nameController.text;
    users.add({"name": name});
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        // app bar
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh),
            )
          ],
        ),

        // body :
        body: 
            GridView.builder(
              itemCount: dataList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemBuilder: (context, i) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(child: Icon(Icons.hail_outlined)),
                        Text('${dataList[i]['name']}'),
                      ],
                    ),
                  ),
                );
              })
         );
  }
}

