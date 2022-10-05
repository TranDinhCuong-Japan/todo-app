import 'package:flutter/material.dart';

class ListTileShare{

  static Widget showListTile(String title, String subtitle, Function onTapEdit, Function onPressedDelete){
   return ListTile(
                      onTap: () {
                        onTapEdit();
                      },
                      leading: const FlutterLogo(size: 50),
                      title: Text(title),
                      subtitle: Text(subtitle),
                      trailing: TextButton.icon(
                        onPressed: () {
                          onPressedDelete();
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text(''),
                      ),
                    );
  }
}