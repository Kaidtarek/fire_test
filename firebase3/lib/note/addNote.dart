// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/note/viewNote.dart';
import 'package:flutter/material.dart';
import 'package:firebase3/auth/home.dart';
import 'package:firebase3/compenment/customButton.dart';
import 'package:firebase3/compenment/textAddCategory.dart';

class AddNewNote extends StatefulWidget {
  const AddNewNote({
    Key? key,
    required this.firstDoc,
  }) : super(key: key);
  final String firstDoc;
  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories').doc(widget.firstDoc).collection('note');
    AddNote() async {
      try {
        isLoading = true;
        if (mounted) {
          setState(() {});
        }
            DocumentReference response = await categories.add({
            'note': name.text,
          });
        
        isLoading = false;
        if (mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NoteView(currentDoc: widget.firstDoc)));
        }
      } catch (e) {
        isLoading = false;
        setState(() {});
        print('error uploading cause : $e');
      }
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('jello'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                CustomTextFormAdd(
                  myController: name,
                  hintTitle: 'new Note',
                ),
                CustomButton(
                  name: 'add',
                  onPressed: () {
                    if (name.text.isEmpty) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'type somethink',
                        desc: 'ensure that you type name of new Note',
                        btnCancelOnPress: () {},
                      ).show();
                    } else {
                      print("the passed name is :${name.text}");
                      AddNote();
                    }
                  },
                  my_color: Colors.orange,
                )
              ],
            ),
    );
  }
}
