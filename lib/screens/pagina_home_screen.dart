import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlinesports_flutter/screens/sign_in_screen.dart';

import '../utils/color_utils.dart';
import 'aggiungiNotizia.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 String? firstName;

 bool Calcio=false;
 bool Basket=false;
 bool Pallavolo=false;
 bool Formula_uno=false;
 bool Nuoto=false;
 bool Tennis=false;
  DocumentReference user = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.email.toString());

   @override
  Widget build(BuildContext context) {
   user.get().then((DocumentSnapshot ds){
      firstName= ds['nome'].toString();
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

                     const Text("Benvenuto    ", style: TextStyle(fontSize: 20),),

                     Text(style: const TextStyle(fontSize: 20),  firstName.toString()+"  "),

                    ElevatedButton(
                      style:  ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                      child: const Text("Disconnetti") ,
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print("Disconnesso");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignInScreen()));

                        });
                      },
                    ),
                  ]),

                  ElevatedButton(onPressed:() {Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>aggiungi_notizia()));}, child: const Text("Aggiungi una notizia"),
                      style:  ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ))),
                  Row(children:<Widget>[(
                    Switch(
                    onChanged: (value) {
                     setState(() {
                      Tennis = value;
                     });
                  },
                   value: Tennis,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.white,
                  inactiveThumbColor: Colors.white12,
                  inactiveTrackColor: Colors.white12,
        )),


                    Text('Tennis', style: TextStyle(fontSize: 20),),

                     Switch(
                       onChanged: (value) {
                        setState(() {
                          Basket = value;
                           });},
                           value: Basket,
                        activeColor: Colors.white,
                        activeTrackColor: Colors.white,
                        inactiveThumbColor: Colors.white12,
                       inactiveTrackColor: Colors.white12,
                    ),


                     Text('Basket', style: TextStyle(fontSize: 20),),
                      Switch(
                      onChanged: (value) {
                      setState(() {
                      Pallavolo = value;
                     });
                     },
                      value: Pallavolo,
                       activeColor: Colors.white,
                       activeTrackColor: Colors.white,
                       inactiveThumbColor: Colors.white12,
                        inactiveTrackColor: Colors.white12,
        ),


                    Text('Pallavolo', style: TextStyle(fontSize: 20),),]),
                  Row(children:<Widget>[(
                  Switch(
                    onChanged: (value) {
                     setState(() {
                    Formula_uno = value;
                    });
                   },
                    value: Formula_uno,
                    activeColor: Colors.white,
                   activeTrackColor: Colors.white,
                     inactiveThumbColor: Colors.white12,
                    inactiveTrackColor: Colors.white12,
                  )),


                      Text('Formula uno', style: TextStyle(fontSize: 20),
                        ),
                    Switch(
                      onChanged: (value) {
                        setState(() {
                          Nuoto = value;
                        });
                      },
                      value: Nuoto,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Colors.white12,
                      inactiveTrackColor: Colors.white12,
                    ),


                    Text('Nuoto', style: TextStyle(fontSize: 20)),]),
                  Row(children:<Widget>[(Switch(
                  onChanged: (value) {
                   setState(() {
                  Calcio = value;
                   });
                    },
                   value: Calcio,
                  activeColor: Colors.white,
                   activeTrackColor: Colors.white,
                   inactiveThumbColor: Colors.white12,
                  inactiveTrackColor: Colors.white12,
        )),


                    Text('Calcio', style: TextStyle(fontSize: 20),)])



  ]))
    )));


  }
  }

