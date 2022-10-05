import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/modes/userinfo.dart';

class AuthDatabase extends ChangeNotifier {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('userinfo');
  final Stream<QuerySnapshot> _userInfoStream =
      FirebaseFirestore.instance.collection('userinfo').snapshots();

  Stream<QuerySnapshot> getUserInfoStream() => _collectionReference.snapshots();

//insert data from database
  void insertData(String name, String phone) async {
    var user = {'name': name, 'phone': phone};
    await _collectionReference.add(user).then((user) {}).catchError((error) {
      // print(error.toString());
    });
  }

  List<UserInfoTodo> userInfors = [];

  void fetchUserInfoList() {
    _userInfoStream.listen((snapshot) {
      final List<UserInfoTodo> userInforTodo =
          snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return UserInfoTodo(
            referenceId: document.id, name: data['name'], phone: data['phone']);
      }).toList();
      userInfors = userInforTodo;
      notifyListeners();
    });
  }

// Update data
  void updateUserInfo(String documentid, String name, String phone) async {
    var user = {'name': name, 'phone': phone};
    await _collectionReference
        .doc(documentid)
        .update(user)
        .then((value) {})
        .catchError((onError) {
      print(onError.toString());
    });
  }

// delete data
  void deleteUserInfo(String documentid) async {
    await _collectionReference
        .doc(documentid)
        .delete()
        .then((value) {})
        .catchError((onError) {
      print(onError.toString());
    });
  }
}
