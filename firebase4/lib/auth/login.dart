import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase4/compenment/customButton.dart';
import 'package:firebase4/compenment/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserData {
  final String id;
  final String email;

  UserData(this.id, this.email);
}

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return MaterialApp(
        home: Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
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
                  Text('Login',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  Text(
                    'Login to continue using this app',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  CustomTextForm(myController: email, hintTitle: 'email'),
                  CustomTextForm(myController: password, hintTitle: 'password'),
                  Container(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                          onPressed: () {}, child: Text('forget password'))),
                ],
              ),
            ),
            CustomButton(
              name: 'Login',
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email.text, password: password.text);
                  if (FirebaseAuth.instance.currentUser!.emailVerified) {
                    Navigator.of(context).pushReplacementNamed('home');
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'your not robot',
                      desc: 'please verified your email',
                      btnCancelOnPress: () {},
                      //btnOkOnPress: () {},
                    ).show();
                  }
                } on FirebaseAuthException catch (e) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'invalide login',
                    desc: 'invalide password or email',
                    btnCancelOnPress: () {},
                    //btnOkOnPress: () {},
                  ).show();
                }
              },
              my_color: Colors.orange,
            ),
            CustomButton(
              name: 'Login with google',
              onPressed: () {},
              ihaveImage: 'images/google.png',
              my_color: Colors.indigo,
            ),
            SizedBox(height: 5),
            Center(
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('register'),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "you don't have account  ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: "Register",
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
