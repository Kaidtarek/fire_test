import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/auth/home.dart';
import 'package:firebase3/compenment/textEditCategory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase3/compenment/customButton.dart';
import 'package:firebase3/compenment/textAddCategory.dart';

class EditElement extends StatefulWidget {
  const EditElement({
    Key? key,
    required this.oldName,
    required this.docId,
  }) : super(key: key);
  final String oldName;
  final String docId;

  @override
  State<EditElement> createState() => _EditElementState();
}

class _EditElementState extends State<EditElement> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');
    editCategory() async {
      try {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }
        await categories.doc(widget.docId).update({"category": name.text});
        print('think its update to ${name.text}');
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('home');
        }
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
  name.dispose();
}
    @override
    void initState() {
      super.initState();
      name.text = widget.oldName;
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
                  oldName2: widget.oldName,
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                    }
                  },
                  my_color: Colors.orange,
                )
              ],
            ),
    );
  }
}
