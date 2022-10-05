import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/modes/userinfo.dart';

class RealTimeDatabaseToDo extends ChangeNotifier {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('userinfo');

  // insert data in Realtime database
  void insertData(String name, String phone) {
    var userInfo = ({'name': name, 'phone': phone});
    _databaseReference
        .push()
        .set(userInfo)
        .then((userinfo) {})
        .catchError((error) {
      print('realtimedb insert data error: ${error.toString()}');
    });
  }

  List<UserInfoTodo> lists = [];

  // read data
  void readData() {
    _databaseReference.onValue.listen((DatabaseEvent event) {
      Map<String, dynamic> data = event.snapshot.value as Map<String, dynamic>;
      List<UserInfoTodo> liststData = data.entries.map((e) {
        return UserInfoTodo(
            referenceId: e.key, name: e.value['name'], phone: e.value['phone']);
      }).toList();
      lists = liststData;
      notifyListeners();
    });
  }

  // update data
  void updateData(String id, String name, String phone) async {
    var user = {'name': name, 'phone': phone};
    await FirebaseDatabase.instance
        .ref('userinfo/$id')
        .update(user)
        .then((value) {})
        .catchError((error) {
      print(error.toString());
    });
  }

  // delete data
  void deleteData(String id) async {
    await FirebaseDatabase.instance
        .ref('userinfo/$id')
        .remove()
        .then((value) {})
        .catchError((onError) {
      print(onError.toString());
    });
  }
}
