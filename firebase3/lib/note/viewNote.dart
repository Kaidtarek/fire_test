import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/auth/home.dart';
import 'package:firebase3/note/addNote.dart';
import 'package:firebase3/note/editNote.dart';
import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  final String currentDoc;
  const NoteView({super.key, required this.currentDoc});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot recived = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.currentDoc)
        .collection('note')
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
                    builder: (BuildContext context) =>
                        AddNewNote(firstDoc: widget.currentDoc)));
              },
              child: Icon(Icons.add)),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              },
              icon: Icon(Icons.back_hand_rounded),
            ),
            title: Text('heyy'),
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print('was tapping');
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
                                .doc(widget.currentDoc)
                                .collection('note')
                                .doc(data[index].id)
                                .delete();
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NoteView(currentDoc: widget.currentDoc)));
                                print('first doc : ${data[index]['note']}');
                                print('second doc : ${widget.currentDoc}');

                          },
                          btnOkOnPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => EditNote(
                                        oldNote: data[index]['note'],
                                        firstDoc: widget.currentDoc,
                                        secondDoc: data[index].id)));

                            print('old note is ${data[index]['note']}');
                            print('primery doc is :${widget.currentDoc}');
                            print('doc id is ${data[index].id}');
                            // (categories) ++ c7 ++ (note) ++ zm ++ note= call my family
                          },
                        ).show();
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text('${data[index]['note']}'),
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
