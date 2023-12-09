import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/auth/home.dart';
import 'package:firebase3/compenment/customButton.dart';
import 'package:firebase3/compenment/textAddCategory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddElement extends StatefulWidget {
  const AddElement({super.key});

  @override
  State<AddElement> createState() => _AddElementState();
}

class _AddElementState extends State<AddElement> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');
    AddCategory() async {
      try {
        if (mounted) {
          isLoading = true;
          setState(() {});
        }
        DocumentReference response = await categories.add({
          'category': name.text,
          'uid': FirebaseAuth.instance.currentUser!.uid
        });

        if (mounted) {
          isLoading = false;
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomePage()));
        }
      } catch (e) {
        if (mounted) {
          isLoading = false;
          setState(() {});
          print('error uploading cause : $e');
        }
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
                  hintTitle: 'new category',
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
                        desc: 'ensure that you type name of new category',
                        btnCancelOnPress: () {},
                      ).show();
                    } else {
                      print("the passed name is :${name.text}");
                      AddCategory();
                     
                    }
                  },
                  my_color: Colors.orange,
                )
              ],
            ),
    );
  }
}
