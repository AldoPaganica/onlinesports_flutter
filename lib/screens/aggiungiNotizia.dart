import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlinesports_flutter/screens/pagina_home_screen.dart';
import 'package:onlinesports_flutter/screens/sign_up_screen.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class aggiungi_notizia extends StatefulWidget {
  const aggiungi_notizia({Key? key}) : super(key: key);

  @override
  aggiungiNotizia createState() => aggiungiNotizia();
}

class aggiungiNotizia extends State<aggiungi_notizia> {
  TextEditingController notizia = TextEditingController();
  String? ambito;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Aggiungi notizia",
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
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
               TextField( cursorColor: Colors.white,
                         style: TextStyle(color: Colors.white),
                      controller: notizia,
                      decoration: InputDecoration(


                        prefixIcon: const Icon(
                       Icons.newspaper_outlined,
                       color: Colors.white70,
                   ),

                 labelText:"Aggiungi una notizia",
                 labelStyle: TextStyle(color: Colors.white),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white30,
              enabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(width: 3, color: Colors.white30), //<-- SEE HERE
                borderRadius: BorderRadius.circular(30),
              ),

              ),),

                SizedBox(width: 40),
                ListTile(
                  title: const Text('Calcio', style: TextStyle(color: Colors.white),),
                  leading: Radio(
                    value: "Calcio",
                    groupValue: ambito,
                    activeColor: Colors.white,
                    onChanged: ( value) {
                      setState(() {
                        ambito = value.toString();
                      });

                    },

                  ),
                ),
                   SizedBox(width: 40),
                   ListTile(title: const Text("Tennis", style: TextStyle(color: Colors.white),),
                     leading:
                     Radio(value: 'Tennis', groupValue: ambito,
                       activeColor: Colors.white,
                       onChanged:(value){
                     setState(() {
                       ambito= value.toString();
                     });
                   },),),
                   SizedBox(width: 40),
                   ListTile(
                     title: const Text("Formula uno", style: TextStyle(color: Colors.white),),leading:
                    Radio(value: 'Formula Uno', groupValue:ambito,
                     activeColor: Colors.white,
                     onChanged:(value){
                     setState(() {
                       ambito= value.toString();
                     });
                   },),),



                    SizedBox(width: 40),
                    ListTile(title: const Text("Pallavolo", style: TextStyle(color: Colors.white),),leading:
                      Radio(value: 'Pallavolo', groupValue: ambito,
                      activeColor: Colors.white,
                      onChanged:(value){
                      setState(() {
                        ambito= value.toString();
                      });
                    },
                    ),),
                    SizedBox(width: 40),
                    ListTile(title: const Text("Basket", style: TextStyle(color: Colors.white),),leading:
                      Radio(value: 'Basket', groupValue: ambito,
                      activeColor: Colors.white,
                      onChanged:(value){
                      setState(() {
                        ambito= value.toString();
                      });
                    },),),
                    SizedBox(width: 40),
                    ListTile(title: const Text("Nuoto", style: TextStyle(color: Colors.white),),leading:
                      Radio(value: 'Nuoto', groupValue:ambito,
                      activeColor: Colors.white,onChanged:(value){
                      setState(() {
                        ambito= value.toString();
                      });
                    },),),
                    firebaseUIButton(context, "Salva", ()async{
                      FirebaseFirestore.instance.collection("Notizie").add({
                        'notizia': notizia.text,
                         'ambito':ambito.toString(),
                        'utente': FirebaseAuth.instance.currentUser?.email
                      }
                      );
                    })

      ]),
    ))));
  }




}