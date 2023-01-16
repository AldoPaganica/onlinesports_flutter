import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlinesports_flutter/screens/sign_in_screen.dart';

import '../utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DocumentReference user = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.email.toString());

  String? firstName;


  @override
  Widget build(BuildContext context) {

    user.get().then((DocumentSnapshot ds) {
      firstName = ds['nome'];
      print(firstName);
    });

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)

        ),
        child: SingleChildScrollView(
          child: Padding(
           padding: EdgeInsets.fromLTRB(
             5, MediaQuery.of(context).size.height * 0.1, 5, 0),

              child: Column(
                children:  <Widget>[
                Row(
                  children:<Widget>[

                     const Text("Benvenuto", style: TextStyle(fontSize: 20)),
                     Text(firstName!, style: TextStyle(fontSize: 20)),

                    ElevatedButton(
                      child: const Text("Disconnetti"),
                      style:  ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )) ,
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print("Disconnesso");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignInScreen()));

                        });
                      },
                    ),
                  ]),

                  ElevatedButton(onPressed:() {}, child: const Text("Aggiungi una notizia"),
                      style:  ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )))

  ]
    ))

        )));


  }
}

