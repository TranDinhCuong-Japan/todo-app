import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/realtime_database.dart';
import 'package:todo/modes/userinfo.dart';
import 'package:todo/share/appbar_share.dart';
import 'package:todo/share/form_share.dart';
import 'package:todo/share/listview_share.dart';

class RealtimePage extends StatefulWidget {
  const RealtimePage({Key? key}) : super(key: key);

  @override
  State<RealtimePage> createState() => _RealtimePageState();
}

class _RealtimePageState extends State<RealtimePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final RealTimeDatabaseToDo _databaseToDo = RealTimeDatabaseToDo();

  bool _isStatusButton = true;

  final String _titleAppBar = 'Realtime Database page';
  String _id = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RealTimeDatabaseToDo>(
      create: (_) => RealTimeDatabaseToDo()..readData(),
      child: Scaffold(
        appBar: AppBarShare.showAppBar(_titleAppBar),
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
                child: Consumer<RealTimeDatabaseToDo>(
                    builder: (context, model, child) {
                  List<UserInfoTodo> lists = model.lists;

                  if (lists.isEmpty) {
                    return const CircularProgressIndicator();
                  }

                  void _onTapEdit(index) {
                    _id = lists[index].referenceId.toString();
                    setState(() {
                      _nameController.text = lists[index].name.toString();
                      _phoneController.text = lists[index].phone.toString();
                      _isStatusButton = false;
                    });
                  }

                  onPressedDelete(index) {
                    _databaseToDo
                        .deleteData(lists[index].referenceId.toString());
                  }

                  return ListViewShare.showListView(lists, (index) {
                    _onTapEdit(index);
                  }, (index) {
                    onPressedDelete(index);
                  });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onAdd() {
    _databaseToDo.insertData(_nameController.text, _phoneController.text);
    setState(() {
      _nameController.text = '';
      _phoneController.text = '';
    });
  }

  onEdit() {
    _databaseToDo.updateData(_id, _nameController.text, _phoneController.text);
    setState(() {
      _nameController.text = '';
      _phoneController.text = '';
      _isStatusButton = true;
    });
  }
}
