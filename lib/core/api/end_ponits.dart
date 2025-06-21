class EndPoint {
  // static String baseUrl = "http://127.0.0.1:8000/";
  static String baseUrl = "http://192.168.143.79:8000/";
  static String signIn = "users/login/";
  static String signUp = "users/createuser/";
  static String reports = "reports/";



  // Get reports by a specific user
  static String getReportsByUser(dynamic userId) {
    return "reports/user-reports?user_id=$userId";
  }


  // Get user details
  static String getUser(dynamic id) {
    return "users/list/$id/";
  }
}

class ApiKey {
  static String status = "status";
  static String errorMessage = "errorMessage";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String id = "id";
  static String message = "message";
  static String name = "username";
  static String firstname = "first_name";
  static String lastname = "last_name";
  static String is_active = "is_active";
  static String nom = "nom";
  static String prenom = "prenom";
  static String matricule = "matricule_de_voiture";
  static String latitude = "latitude";
  static String longitude = "longitude";
  static String phone = "numero_de_telephone";

  // Report related fields
  static String title = "title";
  static String description = "description";
  static String severity = "severity";
  static String category = "category";
  static String reportLatitude = "latitude";
  static String reportLongitude = "longitude";
  static String image = "image";
  static String video = "video";
  static String user = "user";  // User who created the report
}
