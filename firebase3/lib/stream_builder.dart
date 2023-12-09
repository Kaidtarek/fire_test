import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamBuilderExample extends StatefulWidget {
  const StreamBuilderExample({super.key});

  @override
  State<StreamBuilderExample> createState() => _StreamBuilderExampleState();
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
      List <QueryDocumentSnapshot> data = [];
    void initData()async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot userData = await users.get();
    userData.docs.forEach((element) {data.add(element);});
    setState(() {});
  }
  @override
  void initState() {
    initData();
    // TODO: implement initState
    super.initState();
  }
  Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: StreamBuilder(
        stream: collectionStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {

                return InkWell(
                  onTap: () {
                  DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(data[index].id);
                  FirebaseFirestore.instance.runTransaction((transaction) async{
                    DocumentSnapshot snapshot = await transaction.get(documentReference);
                    if (snapshot.exists) {
                      var userData = snapshot.data();
                      if (userData is Map<String,dynamic>) {
                        int credit = userData['money'] + 100;
                        transaction.update(documentReference, {"money":credit});
                      }
                    }
                  });
                  },
                  child: ListTile(
                    title: Text(snapshot.data!.docs[index]['username']),
                    trailing:
                        Text(snapshot.data!.docs[index]['money'].toString()),
                  ),
                );
              });
        },
      ),
    ));
  }
}
