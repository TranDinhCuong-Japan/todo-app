import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/auth_firebase_database.dart';
import 'package:todo/screens/page/firestore_page.dart';
import 'package:todo/screens/page/mysql_page.dart';
import 'package:todo/screens/page/realtime_page.dart';

class StreamBuisderUser extends StatefulWidget {
  const StreamBuisderUser({Key? key}) : super(key: key);

  @override
  State<StreamBuisderUser> createState() => _StreamBuisderUserState();
}

class _StreamBuisderUserState extends State<StreamBuisderUser> {
  final AuthDatabase _authDatabase = AuthDatabase();

  int _currentTab = 0;
  Widget _currentScreen = const StreamBuisderUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        StreamBuilder<QuerySnapshot>(
          stream: _authDatabase.getUserInfoStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Text('${ds['name']} - ${ds['phone']}');
              },
            );
          },
        ),
        
      ]),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              minWidth: 40,
              onPressed: () {
                setState(() {
                  _currentTab = 0;
                  _currentScreen = const FirestorePage();
                });
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.store,
                      color: _currentTab == 0 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      'Firestore',
                      style: TextStyle(
                          color: _currentTab == 0 ? Colors.blue : Colors.grey),
                    )
                  ]),
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: () {
                setState(() {
                  _currentTab = 1;
                  _currentScreen = const RealtimePage();
                });
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm,
                      color: _currentTab == 1 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      'Realtime',
                      style: TextStyle(
                          color: _currentTab == 1 ? Colors.blue : Colors.grey),
                    )
                  ]),
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: () {
                setState(() {
                  _currentTab = 2;
                  _currentScreen = const MysqlPage();
                });
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.storage,
                      color: _currentTab == 2 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      'Mysql',
                      style: TextStyle(
                          color: _currentTab == 2 ? Colors.blue : Colors.grey),
                    )
                  ]),
            )
          ],
        ),
      )),
    );
  }
}
