import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  // Function to store authentication data
  Future<void> storeUserData(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  // Function to get the authentication token
  Future<String?> fetchEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = await prefs.getString('email');
    return email;
  }

  // Function to check if the user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('email');
    return authToken != null;
  }

  // Function to clear authentication data on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    print("Logged out");
  }
}
