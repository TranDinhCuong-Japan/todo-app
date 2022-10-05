import 'package:flutter/material.dart';

class AppBarShare{

  static PreferredSizeWidget showAppBar(String titleAppBar){
    return AppBar(
          title: Text(
            titleAppBar,
            style: const TextStyle(fontSize: 20.0),
          ),
          elevation: 0.0,
          centerTitle: true,
        );
  } 
}