import 'package:flutter/material.dart';
import 'package:todo/share/appbar_share.dart';
import 'package:todo/share/form_share.dart';
import 'package:todo/share/listtile_share.dart';

class MysqlPage extends StatefulWidget {
  const MysqlPage({ Key? key }) : super(key: key);

  @override
  State<MysqlPage> createState() => _MysqlPageState();
}

class _MysqlPageState extends State<MysqlPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isStatusButton = true;

  final String _titleAppBar = 'MySQL Database page';


  @override
  void initState() {
    super.initState();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarShare.showAppBar(_titleAppBar),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: FormShare.showFormShare(_nameController, _phoneController,
                _isStatusButton, onAdd, onEdit),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index){


                return ListTileShare.showListTile('title', 'subtitle', onTapEdit, onPressedDelete) ;
              }),
          ),
        ],
      ),
    );
  }

    onAdd() {}

  onEdit() {}

  onPressedDelete() {
  }

  onTapEdit() {
  }
  
}