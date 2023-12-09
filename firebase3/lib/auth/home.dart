import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/auth/login.dart';
import 'package:firebase3/category/add.dart';
import 'package:firebase3/category/edit.dart';
import 'package:firebase3/note/viewNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot recived = await FirebaseFirestore.instance
        .collection('categories')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(recived.docs);
    await Future.delayed(Duration(milliseconds: 500));
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    print('data was get it');
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.orange),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[50],
              titleTextStyle: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              iconTheme: IconThemeData(color: Colors.orange)),
        ),
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddElement()));
              },
              child: Icon(Icons.add)),
          appBar: AppBar(title: Text('welcoom'), actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Login()) );
                  
                },
                icon: Icon(Icons.logout_outlined)),
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ]),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print("the selected id is ${data[index].id}");
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NoteView(
                            currentDoc: data[index].id,
                          );
                        }));
                      },
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Warinig',
                          desc: 'you will delete the item',
                          btnOkText: 'edit',
                          btnCancelText: 'delete',
                          btnCancelOnPress: () async {
                            await FirebaseFirestore.instance
                                .collection('categories')
                                .doc(data[index].id)
                                .delete();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage()));
                          },
                          btnOkOnPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => EditElement(
                                    oldName: data[index]['category'],
                                    docId: data[index].id)));
                          },
                        ).show();
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(child: Image.asset('images/folder.png')),
                              Text('${data[index]['category']}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
        ));
  }
}
