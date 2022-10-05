import 'package:flutter/material.dart';

class FormShare {
  static Widget showFormShare(
      TextEditingController nameController,
      TextEditingController phoneController,
      bool isStatusButton,
      Function onAdd,
      Function onEdit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 200,
          child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              )),
        ),
        SizedBox(
          width: 200,
          child: TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a your phone number',
              )),
        ),
        isStatusButton
            ? ElevatedButton(
                onPressed: () {
                  onAdd();
                },
                child: const Text('ADD'))
            : ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.amber),
                onPressed: () {
                  onEdit();
                },
                child: const Text('EDIT')),
      ],
    );
  }
}
