import 'package:flutter/material.dart';
import 'package:todo/screens/page/firestore_page.dart';
import 'package:todo/screens/page/mysql_page.dart';
import 'package:todo/screens/page/realtime_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget _currentScreen = const FirestorePage();
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: PageStorageBucket(), child: _currentScreen),
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
                  _currentTab =0;
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
                  _currentTab =1;
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
                  _currentTab =2;
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
