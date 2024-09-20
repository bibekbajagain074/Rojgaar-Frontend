// "username": "Sulav",
// "type": "user",
// "email": "sulavparajuli82@gmail.com",
// "password": "$2b$10$8CoqUi8SF0/mKKTPd1UhTOsohgiKOMa3vgiMxBxLKFkqNYEgr6E4G",
// "isAvatarImageSet": true,
// "avatarImage": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png",
// "isVerified": false,
// "professional": {
// "skills": []
// },
// "additional": [
// {
// "education": null,
// "experience": null,
// "_id": "65e758a09cb105c899c54d4e"
// }
// ],
// "_id": "65e758a09cb105c899c54d4d",
// "appliedJobs": [],
// "savedJobs": [],
// "events": [],
// "todos": [],
// "__v": 0

import 'dart:convert';

import 'package:roj_gaar_app/models/application_model.dart';
import 'package:roj_gaar_app/models/skills_model.dart';

import 'company_model.dart';

class UserModel {
  String email = '',
      type = '',
      username = '',
      firstName = '',
      lastName = '',
      phoneNumber = '',
      appId = '',
      avatarUrl = '',
      password = '';
  SkillModel? skills;
  List<ApplicationModel> appliedJobs = [];
  List education = [], experience = [], savedJobs = [];
  double currentCtc = 0.0;
  bool isVerified = false, hasAvatar = false;
  CompanyModel? company;

  UserModel({
    required this.email,
    required this.type,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.appId,
    required this.avatarUrl,
    required this.education,
    required this.experience,
    required this.skills,
    required this.appliedJobs,
    required this.savedJobs,
    required this.currentCtc,
    required this.isVerified,
    required this.hasAvatar,
    this.company,
  });

  // "user": {
  // "professional": {
  // "skills": []
  // },
  // "_id": "65eb566026665be20c2e0bd0",
  // "username": "abikk",
  // "type": "user",
  // "email": "abik1@gmail.com",
  // "isAvatarImageSet": true,
  // "avatarImage": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png",
  // "isVerified": false,
  // "additional": [
  // {
  // "education": null,
  // "experience": null,
  // "_id": "65eb566026665be20c2e0bd1"
  // }
  // ],
  // "appliedJobs": [],
  // "savedJobs": [],
  // "__v": 0
  // },
  // "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZWI1NjYwMjY2NjViZTIwYzJlMGJkMCIsImlhdCI6MTcwOTkyMTg5MywiZXhwIjoxNzEwMzUzODkzfQ.1u8kQaGPPwtWIlzlS2wo8mqdZwiBU-xVjf9BRZ2Rf-o"

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    type = json['type'];
    username = json['username'];
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    phoneNumber = json['phone'] ?? '';
    appId = json['additional'][0]['_id'];
    avatarUrl = json['avatarImage'] ?? '';
    education = json['additional'][0]['education'] ?? [];
    experience = json['additional'][0]['experience'] ?? [];
    appliedJobs = List<ApplicationModel>.from(
        (json['appliedJobs'] ?? <ApplicationModel>[])
            .map((model) => ApplicationModel.fromJson(model)));
    savedJobs = json['savedJobs'] ?? [];
    skills = SkillModel.fromJson(json['professional']);
    isVerified = json['isVerified'] ?? false;
    hasAvatar = json['isAvatarImageSet'] ?? false;
    // company = json['company'];
  }

  static Map<String, dynamic> toMap(UserModel user) => <String, dynamic>{
        'email': user.email,
        'type': user.type,
        'username': user.username,
        '_id': user.appId,
        'avatarImage': user.avatarUrl,
        'education': user.education,
        'experience': user.experience,
        'skills': user.skills,
        'isVerified': user.isVerified,
        'isAvatarImageSet': user.hasAvatar,
        'company': user.company,
      };

  static String serialize(UserModel model) =>
      json.encode(UserModel.toMap(model));

  static UserModel deserialize(String json) =>
      UserModel.fromJson(jsonDecode(json));
}
