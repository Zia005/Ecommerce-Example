import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  final String userName = 'username';
  final String email = 'email';

  Future<void> saveLoginDataToSharedPreference(String userName, String email) async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(this.userName, userName);
    preferences.setString(this.email, email);
  }

  Future<void> saveUserNameToSharedPreference(String userName) async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(this.userName, userName);
  }


  Future<void> deleteLoginDataToSharedPreference() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }


  Future<String?> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(this.userName);
  }


  Future<String?> getEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? userEmail;
    userEmail = pref.getString(this.email);
    return userEmail;
  }

}