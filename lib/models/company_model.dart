// "_id": "65ec530c3da2ceae87bd2076",
// "name": "ABCDE",
// "isAvatarImageSet": true,
// "avatarImage": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png",
// "isVerified": false,
// "jobs": [],
// "__v": 0,
// "about": "About the company",
// "country": "United States",
// "desc": "Description of the company",
// "phone": "1234567890",
// "region": "California",
// "sector": "Technology"

class CompanyModel {
  String id = '',
      name = '',
      email = '',
      avatarUrl = '',
      about = '',
      country = '',
      desc = '',
      phone = '',
      region = '',
      sector = '';
  bool isVerified = false, isActive = false, hasAvatarSet = false;
  List jobs = [], applicants = [], categories = [];
  DateTime? openDate = DateTime.now(), closeDate = DateTime.now();

  CompanyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.isVerified,
    required this.isActive,
    required this.hasAvatarSet,
    required this.jobs,
    required this.categories,
    required this.applicants,
    required this.openDate,
    required this.closeDate,
  });

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'] ?? '';
    about = json['about'] ?? '';
    country = json['country'] ?? '';
    desc = json['desc'] ?? '';
    phone = json['phone'] ?? '';
    region = json['region'] ?? '';
    sector = json['sector'] ?? '';
    avatarUrl = json['avatarImage'] ?? '';
    isActive = json['isActive'] ?? false;
    isVerified = json['isVerified'] ?? false;
    hasAvatarSet = json['isAvatarImageSet'] ?? false;
    jobs = json['jobs'] ?? [];
    categories = json['categories'] ?? [];
    applicants = json['applicants'] ?? [];
    openDate = (json['openDate']) != null
        ? DateTime.parse(((json['openDate'])
                .substring(0, (json['openDate']).lastIndexOf('T')))
            .toString()
            .replaceAll('T', ''))
        : DateTime.now();
    closeDate = (json['closeDate']) != null
        ? DateTime.parse(((json['closeDate'])
                .substring(0, (json['closeDate']).lastIndexOf('T')))
            .toString()
            .replaceAll('T', ''))
        : DateTime.now();
  }
}
