// "title": "Software Developer",
// "sector": "IT",
// "skills": [
// "JavaScript",
// "Node.js",
// "React"
// ],
// "summary": "Experienced software developer."
class SkillModel {
  String sector = '', title = '', summary = '';
  List skills = [];

  SkillModel({
    required this.sector,
    required this.title,
    required this.skills,
    required this.summary,
  });

  SkillModel.fromJson(Map<String, dynamic> json) {
    sector = json['sector'] ?? '';
    title = json['title'] ?? '';
    skills = json['skills'] ?? [];
    summary = json['summary'] ?? '';
  }
}
