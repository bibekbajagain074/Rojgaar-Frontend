// {
// "professional": {
// "title": "Flutter Dev",
// "sector": "Software Development",
// "skills": [
// "Flutter",
// "React Native"
// ],
// "summary": "Senior Mobile Developer"
// },
// "_id": "65ee70104ac201e69a0fe8be",
// "username": "abik",
// "type": "user",
// "email": "abik@gmail.com",
// "password": "$2b$10$s61AvTZczDEVORn6lAOUx.GcuHy14fyOYwnNMXD0PCQaMdjZ0ef02",
// "isAvatarImageSet": true,
// "avatarImage": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-
// "isVerified": false,
// "additional": [
// {
// "education": null,
// "experience": null,
// "_id": "65ee70104ac201e69a0fe8bf"
// }
// ],
// "__v": 2,
// "firstName": "abik",
// "lastName": "vaidhya",
// "phone": ""
// "status": "New",
// "appliedDate": "2024-03-11T15:06:44.625Z",
// "_id": "65ef1e040a5952f39721a5a2"
// },

import 'package:roj_gaar_app/models/skills_model.dart';

class ApplicantModel {
  String username = '',
      id = '',
      status = '',
      firstName = '',
      lastName = '',
      email = '',
      avatarUrl = '';
  bool hasAvatar = true;
  List education = [], experience = [];
  SkillModel? professional;

  ApplicantModel({
    required this.id,
    required this.status,
    required this.username,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.education,
    required this.experience,
    required this.avatarUrl,
    required this.hasAvatar,
  });

  ApplicantModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    username = json['username'] ?? '';
    firstName = json['firstName'] ?? '';
    status = json['status'] ?? 'new';
    email = json['email'] ?? '';
    lastName = json['lastName'] ?? '';
    avatarUrl = json['avatarImage'] ?? '';
    hasAvatar = json['isAvatarImageSet'] ?? false;
    experience = json['additional'][0]['experience'] ?? [];
    education = json['additional'][0]['education'] ?? [];
    professional = SkillModel.fromJson(json['professional']);
  }
}
