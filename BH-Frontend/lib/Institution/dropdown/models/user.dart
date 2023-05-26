import 'dart:convert';
import 'package:http/http.dart' as http;

class UserResponse {
  String token;
  User user;

  UserResponse({required this.token, required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  String? userId;
  String name;
  String surname;
  String username;
  String email;
  String? password;
  String phoneNumber;
  String? createdAt;
  String city;
  List<Role>? roles;
  List<String>? documents;

  User({
    this.userId,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    this.password,
    required this.phoneNumber,
    this.createdAt,
    required this.city,
    this.roles,
    this.documents,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      surname: json['surname'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phone_number'],
      createdAt: json['created_at'],
      city: json['city'],
      roles: json['roles'] != null
          ? List<Role>.from(json['roles'].map((x) => Role.fromJson(x)))
          : null,
      documents: json['documents'] != null
          ? List<String>.from(json['documents'])
          : null,
    );
  }
}

class Role {
  int roleId;
  String name;
  String authority;

  Role({required this.roleId, required this.name, required this.authority});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json['role_id'],
      name: json['name'],
      authority: json['authority'],
    );
  }
}