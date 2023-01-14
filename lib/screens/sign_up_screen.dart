import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onlinesports_flutter/screens/pagina_home_screen.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'package:calendar_view/calendar_view.dart';

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
  final CalendarControllerProvider _calendarController= CalendarControllerProvider(
  controller: EventController(),
  child: MaterialApp(
      // Your initialization for material app.
      ),
  );




  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("Users");

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
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

          child: SingleChildScrollView(

              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
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

                 MonthView(controller: EventController(),
                   // to provide custom UI for month cells.
                   cellBuilder: (date, events, isToday, isInMonth) {
                     // Return your widget to display as month cell.
                     return Container();
                   },
                   minMonth: DateTime(1940),
                   maxMonth: DateTime(2023),
                   initialMonth: DateTime(2008),
                   cellAspectRatio: 1,
                   onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
                   onCellTap: (events, date) {
                     // Implement callback when user taps on a cell.
                     print(events);
                   },
                   startDay: WeekDays.monday, // To change the first day of the week.
                   // This callback will only work if cellBuilder is null.
                   onEventTap: (event, date) => print(event),
                   onDateLongPress: (date) => print(date),
                 ),
                    const SizedBox(
                      height: 100,
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
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CalendarControllerProvider<Object?>>('_calendarController', _calendarController));
  }
}


