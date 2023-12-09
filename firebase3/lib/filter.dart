import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterFirestore extends StatefulWidget {
  const FilterFirestore({super.key});

  @override
  State<FilterFirestore> createState() => _FilterFirestoreState();
}

class _FilterFirestoreState extends State<FilterFirestore> {
  Future<void> batchfunc(){
    
        DocumentReference doc1 =
            FirebaseFirestore.instance.collection('users').doc('1');
        DocumentReference doc2 =
            FirebaseFirestore.instance.collection('users').doc('2');

        WriteBatch batch = FirebaseFirestore.instance.batch();
        batch.set(doc1, {
          'age': 13,
          'username': "doce1",
          'phone': "01828339",
          'money': 11,
        });
        batch.set(doc2, {
          'age': 26,
          'username': "doc2",
          'phone': "01010101",
          'money': 406,
        });
       return batch.commit();
        
  }
  List<QueryDocumentSnapshot> data = [];
  void initData() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot userdata = await users.get();
    userdata.docs.forEach((element) {
      data.add(element);
    });
    setState(() {});
  }

  @override
  void initState() {
    initData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fiter fireStore')),
      floatingActionButton: FloatingActionButton(onPressed: () {
        batchfunc();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => FilterFirestore()));
      }),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              DocumentReference documentReference = FirebaseFirestore.instance
                  .collection('users')
                  .doc(data[i].id);

              FirebaseFirestore.instance.runTransaction((transaction) async {
                DocumentSnapshot snapshot =
                    await transaction.get(documentReference);
                if (snapshot.exists) {
                  var snapshotData = snapshot.data();
                  if (snapshotData is Map<String, dynamic>) {
                    int count = snapshotData['money'] + 100;
                    transaction.update(documentReference, {'money': count});
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => FilterFirestore()));
                  }
                }
              });
            },
            child: Card(
              child: ListTile(
                trailing: Text(
                  "${data[i]['money'].toString()} \$",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    color: Color.fromARGB(255, 191, 133, 115),
                  ),
                ),
                title: Text(
                  data[i]['username'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("age: ${data[i]['age'].toString()}"),
              ),
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
