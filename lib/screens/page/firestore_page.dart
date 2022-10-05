import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/auth_firebase_database.dart';
import 'package:todo/modes/userinfo.dart';
import 'package:todo/share/appbar_share.dart';
import 'package:todo/share/form_share.dart';
import 'package:todo/share/listview_share.dart';

class FirestorePage extends StatefulWidget {
  const FirestorePage({Key? key}) : super(key: key);

  @override
  State<FirestorePage> createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  final AuthDatabase _authDatabase = AuthDatabase();
  final UserInfoTodo userInfoTodo = UserInfoTodo();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _id = '';
  bool _isStatusButton = true;

  final String _appBarTitle = 'Firestore Database page';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthDatabase>(
      create: (_) => AuthDatabase()..fetchUserInfoList(),
      child: Scaffold(
        appBar: AppBarShare.showAppBar(_appBarTitle),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: FormShare.showFormShare(_nameController,
                    _phoneController, _isStatusButton, onAdd, onEdit),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Consumer<AuthDatabase>(builder: (context, model, child) {
                  List<UserInfoTodo> lists = model.userInfors;

                  if (lists.isEmpty) {
                    return const CircularProgressIndicator();
                  }

                  void _onEdit(index) {
                    _id = lists[index].referenceId.toString();
                    setState(() {
                      _nameController.text = lists[index].name.toString();
                      _phoneController.text = lists[index].phone.toString();
                      _isStatusButton = false;
                    });
                  }

                  void _onDelete(index) {
                    _authDatabase
                        .deleteUserInfo(lists[index].referenceId.toString());
                  }

                  return ListViewShare.showListView(lists, (index) {
                    _onEdit(index);
                  }, (index) {
                    _onDelete(index);
                  });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAdd() {
    _authDatabase.insertData(_nameController.text, _phoneController.text);
    _nameController.text = '';
    _phoneController.text = '';
  }

  void onEdit() {
    _authDatabase.updateUserInfo(
        _id, _nameController.text, _phoneController.text);
    setState(() {
      _isStatusButton = true;
      _nameController.text = '';
      _phoneController.text = '';
    });
  }
}
