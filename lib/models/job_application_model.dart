import 'package:roj_gaar_app/models/applicant_model.dart';

class JobApplicationModel {
  String id = '', company = '';
  String title = '';
  String category = '';
  String description = '';
  List skills = [], responsibilities = [], requirements = [];
  double salary = 0.0;
  bool isActive = true;
  List<ApplicantModel> applicants = <ApplicantModel>[];

  JobApplicationModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.skills,
    required this.responsibilities,
    required this.requirements,
    required this.company,
    required this.isActive,
    required this.salary,
    required this.applicants,
  });

  JobApplicationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    title = json['title'] ?? '';
    category = json['about'] ?? '';
    skills = json['skills'];
    salary = double.parse((json['sallary'] ?? 0).toString());
    description = json['description'] ?? '';
    responsibilities = json['responsibilities'] ?? [];
    requirements = json['requirements'] ?? [];
    company = json['title'] ?? '';
    isActive = json['isActive'] ?? false;
    applicants = (json['applicants'] == null)
        ? <ApplicantModel>[]
        : List<ApplicantModel>.from((json['applicants'])
            .map((model) => ApplicantModel.fromJson(model)));
  }
}
