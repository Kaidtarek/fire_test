// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/note/viewNote.dart';
import 'package:flutter/material.dart';
import 'package:firebase3/auth/home.dart';
import 'package:firebase3/compenment/customButton.dart';
import 'package:firebase3/compenment/textEditCategory.dart';

class EditNote extends StatefulWidget {
  const EditNote({
    Key? key,
    required this.oldNote,
    required this.firstDoc,
    required this.secondDoc,
  }) : super(key: key);
  final String oldNote;
  final String firstDoc;
  final String secondDoc;


  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    CollectionReference categories =FirebaseFirestore.instance.collection('categories');
    editCategory() async {
      try {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }
        await categories.doc(widget.firstDoc).collection('note').doc(widget.secondDoc).update({"note": name.text});
        print('think its update to ${name.text}');

      } catch (e) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          print('error uploading cause: $e');
        }
      }
    }
@override
void dispose() { 
  super.dispose();
}
    @override
    void initState() {
      name.text = widget.oldNote;
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('jello'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                CustomTextFormEdit(
                  oldName2: widget.oldNote,
                  myController: name,
                ),
                CustomButton(
                  name: 'Edit',
                  onPressed: () {
                    if (name.text.isEmpty) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'type somethink',
                        desc: 'ensure that you want edit the category',
                        btnCancelOnPress: () {},
                      ).show();
                    } else {
                      editCategory();
                      print("the passed name is :${name}");
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NoteView(currentDoc: widget.firstDoc)));
                    }
                  },
                  my_color: Colors.orange,
                )
              ],
            ),
    );
  }
}
