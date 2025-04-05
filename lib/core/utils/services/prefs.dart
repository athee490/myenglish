import 'package:shared_preferences/shared_preferences.dart';

///Shared Preferences class with all variables and methods
class Prefs {
  static const String isLoggedIn = 'isLoggedIn';
  static const String userType = 'userType';
  static const String userId = 'userId';
  static const String email = 'email';
  static const String dob = 'dob';
  static const String token = 'token';
  static const String fcmDeviceToken = 'fcmDeviceToken';
  static const String name = 'name';
  static const String phoneNumber = 'phoneNumber';
  static const String firebaseId = 'firebaseId';
  static const String occupation = 'occupation';
  static const String pincode = 'pincode';
  static const String education = 'education';
  static const String doj = 'doj';
  static const String accName = 'accName';
  static const String accNo = 'accNo';
  static const String accType = 'accType';
  static const String ifsc = 'ifsc';
  static const String courseId = 'courseId';
  static const String courseLevel = 'courseLevel';
  static const String isPaidForResources = 'isPaidForResources';
  static const String tutorId = 'tutorId';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String profilePicture = 'profilePicture';
  static const String tutorVerified = 'tutorVerified';

  static final Prefs _preference = Prefs._internal();

  factory Prefs() {
    return _preference;
  }

  Prefs._internal();

  static Prefs get shared => _preference;
  static SharedPreferences? _pref;

  Future<SharedPreferences?> instance() async {
    if (_pref != null) return _pref;
    await SharedPreferences.getInstance().then((value) {
      _pref = value;
    }).catchError((onErr) {
      _pref = null;
    });

    return _pref;
  }

  String? getString(String key) {
    return _pref?.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _pref!.setString(key, value);
  }

  int? getInt(String key) {
    return _pref?.getInt(key);
  }

  Future<bool> setInt(String key, int value) {
    return _pref!.setInt(key, value);
  }

  bool getBool(String key) {
    if (_pref == null) return false;
    return _pref?.getBool(key) ?? false;
  }

  Future<bool> setBool(String key, bool value) {
    return _pref!.setBool(key, value);
  }

  double? getDouble(String key) {
    return _pref?.getDouble(key);
  }

  Future<bool> setDouble(String key, double value) {
    return _pref!.setDouble(key, value);
  }

  Future<bool?> clearPrefs() async {
    return await _pref?.clear();
  }

  Future<bool> removeKey(String key) async {
    return await _pref!.remove(key);
  }
}
