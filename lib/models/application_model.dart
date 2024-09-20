class ApplicationModel {
  String jobId = '', appliedDate = '', applicationId = '', status = '';

  ApplicationModel({
    required this.jobId,
    required this.appliedDate,
    required this.status,
    required this.applicationId,
  });

  ApplicationModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job'] ?? '';
    appliedDate = json['appliedDate'] ?? '';
    status = json['status'] ?? '';
    applicationId = json['_id'] ?? '';
  }
}
