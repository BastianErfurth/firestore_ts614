import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? annaEmail;
  List contractPartners = [];
  int usercount = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  final users = await FirebaseFirestore.instance
                      .collection("userProfile")
                      .get();
                  final countedUsers = users.docs.length;

                  setState(() {
                    usercount = countedUsers;
                  });
                },
                child: Text("Zähle die Anzhal der Dokumente in einer Sammlung"),
              ),
              SizedBox(height: 8),
              Text("Die Anzahl der Dokuemte beträgt: $usercount"),
              SizedBox(height: 20),
              Divider(),
              TextButton(
                onPressed: () async {
                  final docSnap = await FirebaseFirestore.instance
                      .collection("userProfile")
                      .doc("user_anna")
                      .get();
                  final Map<String, dynamic>? docData = docSnap.data();
                  setState(() {
                    annaEmail = docData?['email'];
                  });
                },
                child: Text("Rufe die Daten eines spezifischen Dokumentes ab"),
              ),
              SizedBox(height: 8),
              Text("Die Emailadresse von Anna ist: ${annaEmail ?? ''}"),
              SizedBox(height: 20),
              Divider(),
              TextButton(
                onPressed: () async {
                  final contractors = await FirebaseFirestore.instance
                      .collection("contractPartners")
                      .get();
                  final List loadedContractPartners = contractors.docs.toList();

                  setState(() {
                    contractPartners = loadedContractPartners;
                  });
                },
                child: Text("Lade alle Dokumente einer Sammlung"),
              ),
              SizedBox(height: 8),
              Text(
                  "Die contractPartner sind: ${contractPartners.map((e) => e.id).join(', ').toString()}"),
            ],
          ),
        ),
      ),
    );
  }
}
