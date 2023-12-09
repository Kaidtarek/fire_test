import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase3/compenment/customButton.dart';
import 'package:firebase3/compenment/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    @override
    void dispose() {
      super.dispose();
      email.dispose();
      password.dispose();
    }

    return MaterialApp(
        home: Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(80)),
                          padding: EdgeInsets.all(20),
                          child: Image.asset('images/logo.png'))),
                  Text('Register',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  Text(
                    'Register to continue using this app',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  CustomTextForm(myController: email, hintTitle: 'email'),
                  CustomTextForm(myController: password, hintTitle: 'password'),
                ],
              ),
            ),
            SizedBox(height: 17),
            CustomButton(
              name: 'Register',
              onPressed: () async {
                print('your email is : ${email.text}');
                print('your password is : ${password.text}');
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  await FirebaseAuth.instance.signOut();
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'your account need verification',
                    desc:
                        'we send email to ${email.text} please verified and came to login',
                    btnOkOnPress: () async {
                      Navigator.of(context).pushNamed('login');
                    },
                  ).show();
                } on FirebaseAuthException catch (e) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'bad form',
                    desc: '${e.code.replaceAll('-', ' ')}',
                  ).show();
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              my_color: Colors.orange,
            ),
            SizedBox(height: 5),
            Center(
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('login'),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "you  have account  ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange))
                ])),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    ));
  }
}
