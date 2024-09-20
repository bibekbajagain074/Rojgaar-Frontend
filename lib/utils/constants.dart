import 'package:flutter/cupertino.dart';

// global variables
final rNavigatorKey = GlobalKey();
const uAccessToken = 'access_token';
const uUser = 'logged_in_user';
const aRememberUser = 'remember_session';

// APP ROUTES
// onboarding
const splashScreen = '/';
const onBoardingSelection = '/onBoardingSelection';
const onBoarding = '/onBoarding';
const login = '/login';
const employeeRegistration = '/employee_registration';
const employerRegistration = '/employer_registration';
// dashboard
const home = '/home';
const dashboard = '/dashboard';
const search = '/search';
const categoryScreen = '/category_screen';
const settings = '/settings';
// profile
const employeeProfile = '/employee_profile';
const employerProfile = '/employer_profile';
const changePassword = '/change_password';
// misc
const otp = '/otp';
const searchJobs = 'jobs';
const searchCategories = 'categories';
const searchEmployees = 'employees';
const searchCompanies = 'companies';
const categoryImageURL =
    'https://th.bing.com/th/id/OIP.8K-QaFzUmpKRW0gCY99VSgHaHa?rs=1&pid=ImgDetMain';
const avatarImageURL =
    'https://th.bing.com/th/id/R.e67e358c72e30a5ec593534154b91ea6?rik=ZqxgM3e1zt79%2fw&pid=ImgRaw&r=0';
const companyImageURL =
    'https://th.bing.com/th/id/R.598b87d3ca24f0e57b1849dc0992357b?rik=aXQpa2unhci3Mg&pid=ImgRaw&r=0';
const jobsImageUrl =
    'https://icon-library.com/images/career-icon-png/career-icon-png-0.jpg';

// label types and font size for text
enum LabelType { title, heading1, heading2, body, small }

enum FontSize { title, heading1, heading2, body, small }

// app primary color
const Color primaryColor = Color(0xFF32628D);
const Color recJobs = Color(0xFFF1DFAA);
const Color availableJobs = Color(0xFFFFDAD6);
const List<Color> categories = [
  Color(0xFFFFDAD6),
  Color(0xFFF1DFAA),
  Color(0xFFEECBEB),
  Color(0xFFD5E4F7),
];

const String lorem =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
