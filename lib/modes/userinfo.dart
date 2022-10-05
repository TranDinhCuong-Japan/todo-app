import 'package:firebase_database/firebase_database.dart';

class UserInfoTodo{
  String? name;
  String? phone;

  String? referenceId;

  UserInfoTodo({this.referenceId,this.name, this.phone});

   Map<String, dynamic> toMap(){
     return{
       'id': referenceId,
        'name': name,
        'phone': phone
     };
   }

@override
   String toString(){
     return'UserInfoTodo{id: $referenceId, name: $name, phone: $phone}';
   }
}
