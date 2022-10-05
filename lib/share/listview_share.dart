import 'package:flutter/material.dart';
import 'package:todo/modes/userinfo.dart';

class ListViewShare {
  static Widget showListView(
      List<UserInfoTodo> lists, Function onTapEdit, Function onPressedDelete) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lists.length,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: () {
              onTapEdit(index);
            },
            leading: const FlutterLogo(size: 50),
            title: Text(lists[index].name.toString()),
            subtitle: Text(lists[index].phone.toString()),
            trailing: TextButton.icon(
              onPressed: () {
                onPressedDelete(index);
              },
              icon: const Icon(Icons.delete),
              label: const Text(''),
            ),
          );
        }));
  }
}
