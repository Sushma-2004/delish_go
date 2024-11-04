import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String documentId = '';
  @HiveField(1)
  String name = '';
  @HiveField(2)
  String phoneNumber = '';
  @HiveField(3)
  String email = '';

  UserModel({
    this.documentId = '',
    this.name= '',
    this.phoneNumber = '',
    this.email = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String docId) {

    
    return UserModel(
      documentId: docId,
      name: (json['name'] is String) ? json['name'] : '',
      phoneNumber: (json['phoneNumber'] is String) ? json['phoneNumber'] : '',
      email: (json['email'] is String) ? json['email'] : '',
    );
  }


  Map<String, dynamic> toJson() {

    return {
      'documentId': documentId,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}
