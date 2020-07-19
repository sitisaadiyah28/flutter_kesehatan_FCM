import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kesehatan/network/NetworkProvider.dart';
import 'package:flutter_kesehatan/ui/Add/AddPage.dart';
import 'package:flutter_kesehatan/ui/list/itemListKesehatanVertical.dart';
import 'package:flutter_kesehatan/ui/list/listItemInfoHorizontal.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BaseEndpoint network = NetworkProvider();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.subscribeToTopic("InternshipTopic");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        final data = message['data'];
        print("Onteset : ${notification['title']}");
        print("Onteset : ${data['image']}");
      },

      //kalau aplikasi mati maka notifikasinya akan muncul
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final notification = message['notication'];
        print("Onteset : ${notification['title']}");
      },

      //Jalan di background aplikasi
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final notification = message['notication'];
        print(notification['title']);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'INFORMASI KESEHATAN',
        ),
        centerTitle: true,
        backgroundColor: Colors.green[500],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 26.0, bottom: 10.0),
            child: Text(
              'Info Kesehatan',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 3.5,
              child: FutureBuilder(
                future: network.getInfoKesehatan(""),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? listItemInfoHorizontal(list: snapshot.data)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 16.0, bottom: 26.0),
            child: Text(
              'Seputar Kesehatan',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
            future: network.getInfoKesehatan(""),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? itemListInfoVertical(list: snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()));
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        elevation: 20.0,
        color: Colors.green[500],
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: ButtonBar(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
