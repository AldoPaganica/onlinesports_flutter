import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onlinesports_flutter/screens/pagina_home_screen.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'package:intl/intl.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _surnameTextController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registrazione",
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
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    reusableTextField("Inserisci l'username", Icons.person_outline, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Inserisci il nome", Icons.person_outline, false,
                        _nameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Inserisci il cognome", Icons.person_outline, false,
                        _surnameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Inserisci l'email", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Inserisci la password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),

                    TextField(
                      controller: dateInput,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),//icon of text field
                          labelText: "Inserisci la tua data di nascita" , labelStyle: TextStyle(color: Colors.white)//label text of field

                      ), style: const TextStyle(color: Colors.white) ,
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2008),
                            firstDate: DateTime(1950),

                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    firebaseUIButton(context, "Registrati", () async{
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );
                      var dbRef = FirebaseFirestore.instance.collection("Users").doc(_emailTextController.text);
                      dbRef.set({'username': _userNameTextController.text,
                                 'nome': _nameTextController.text,
                                 'cognome': _surnameTextController.text,
                                 'email': _emailTextController.text,
                                 'data': dateInput.text
                      })
                        .then((value) {
                        print("Creato un nuovo account");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomeScreen()));
                      }).onError((error, stackTrace) {
                        print("Errore ${error.toString()}");
                      });
                    })
                  ],
                ),
              ))),

    );

  }

}


