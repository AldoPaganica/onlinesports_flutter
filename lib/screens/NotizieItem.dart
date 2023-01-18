

import 'package:flutter/material.dart';

class NotizieItem extends StatefulWidget {
  final String notizia;
  final String ambito;
  final String utente;


  NotizieItem({
    required this.notizia,
    required this.utente,
    required this.ambito
  });

  @override
  _NotizieItemState createState() => _NotizieItemState();
}

class _NotizieItemState extends State<NotizieItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child:
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(

                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(

                        padding: const EdgeInsets.only(left: 8.0, bottom: 0.25),

                        child: Text(
                          widget.notizia,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top:8.0),
                        child: Text(" ${widget.ambito}",
                            style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Creato da: ${widget.utente}",
                            style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                      )
                    ],
                  ),

                ],
              ),
            ),

        ),

      );
  }
}