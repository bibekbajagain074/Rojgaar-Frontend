class APIEndpoints {
  static const baseUrl = 'http://192.168.1.145:5000';
  static const authUrl = '$baseUrl/api/auth';
  static const userUrl = '$baseUrl/api/user';
  static const companyUrl = '$baseUrl/api/company';
  static const jobUrl = '$baseUrl/api/job';
  static const categoryUrl = '$baseUrl/api/category';

  // profile
  static const updatePassword = '$authUrl/updatePassword/';
  static const sendOTP = '$authUrl/sendVerification';
  static const resendOTP = '$authUrl/resendVerification';
  static const verifyOTP = '$authUrl/verify/';

  // employee
  static const employeeRegister = '$authUrl/register';
  static const employeeLogin = '$authUrl/login';
  static const updateEmployeeProfile = '$authUrl/updateUser';

  // company
  static const companyRegister = '$authUrl/register';
  static const companyLogin = employeeLogin;
  static const updateCompanyProfile = '$companyUrl/editCompany';

  // job
  static const applyForJob =
      '$jobUrl/applyForJob'; // send application (for user)
  static const getCompanyJobs = '$jobUrl/getCompanyJobs?user=';
  static const getCompanyJobDetails = '$jobUrl/getCompanyJobDetail?user=';
  static const getAppliedJobList =
      '$jobUrl/appliedJobs'; // list applications (for user)
  static const getSavedJobs = '$jobUrl/savedJobs'; // save job (for user)
  static const getJobDetails = '$jobUrl/getJob?id=';
  static const getAllJobs = '$jobUrl/getAllJobs';
  static const getRecommendedJobs =
      '$companyUrl/getRecommendation'; // get recommended jobs (for user)
  static const editJob = '$jobUrl/editJob'; // edit job details (for company)
  static const getAppliedJobsApplicants = '$jobUrl/getCompanyJobDetail?user=';
  static const postJob = '$jobUrl/addJob'; //  post new job (for company)
  static const getJobApplicants = '$jobUrl/appliedJobsApp';
  static const acceptApplicant =
      '$jobUrl/updateJobStatus'; // update job status (for user)
  static const viewJobStatus =
      '$authUrl/appliedJobsWear'; // check application status

  // categories
  static const getAllCategories = '$categoryUrl/getAllCategories';
  static const getCategoryJobs = '$categoryUrl/getCategory';
  static const addCategory =
      '$categoryUrl/addCategory'; // add new category (for company)
  static const getSectorJobs = '$jobUrl/getSectorJob?sector=';
}
