// "title": "Teacher",
// "about": "Opportunity to become teacher.",
// "description": "Detailed job description.",
// "skills": [
// " Javascript"
// ],
// "responsibilities": [
// "Develop software applications",
// "Collaborate with the team"
// ],
// "requirements": [
// "Bachelor's degree in Physic",
// "Experience with teaching"
// ],
// "sallary": 5000,
// "company": "65e75d369cb105c899c54d6b",
// "openDate": "2024-03-05T18:01:42.496Z",
// "closeDate": "2024-09-11T00:00:00.000Z",
// "isActive": true,
// "applicants": [],
// "_id": "65e75e069cb105c899c54d6e",
// "__v": 0

import 'package:roj_gaar_app/models/application_model.dart';

import 'company_model.dart';

class JobModel {
  String id = '';
  String title = '', status = '';
  String category = '';
  String description = '';
  List skills = [], responsibilities = [], requirements = [];
  List<ApplicationModel> appliedJobs = [];

  // List<ApplicantModel> applicants = [];
  CompanyModel? company;
  late DateTime openDate, closeDate;
  double salary = 0.0;
  bool isActive = true;

  JobModel({
    required this.id,
    required this.title,
    required this.status,
    required this.category,
    required this.description,
    required this.skills,
    required this.responsibilities,
    required this.requirements,
    required this.appliedJobs,
    required this.company,
    required this.openDate,
    required this.closeDate,
    required this.salary,
    required this.isActive,
  });

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'] ?? '';
    status = json['status'] ?? 'New';
    category = json['about'] ?? '';
    skills = json['skills'];
    salary = double.parse((json['sallary'] ?? 0).toString());
    description = json['description'] ?? '';
    responsibilities = json['responsibilities'] ?? [];
    requirements = json['requirements'] ?? [];
    appliedJobs = (json['appliedJobs'] == null)
        ? <ApplicationModel>[]
        : List<ApplicationModel>.from((json['appliedJobs'])
            .map((model) => ApplicationModel.fromJson(model)));
    // applicants = (json['applicants'] == null)
    //     ? <ApplicantModel>[]
    //     : List<ApplicantModel>.from((json['applicants'])
    //         .map((model) => ApplicantModel.fromJson(model)));
    company = CompanyModel.fromJson(json['company']);
    openDate = DateTime.parse(
        ((json['openDate']).substring(0, (json['openDate']).lastIndexOf('T')))
            .toString()
            .replaceAll('T', ''));
    closeDate = DateTime.parse(
        ((json['closeDate']).substring(0, (json['closeDate']).lastIndexOf('T')))
            .toString()
            .replaceAll('T', ''));
    isActive = json['isActive'] ?? false;
  }
}
