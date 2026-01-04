import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/db/app_database.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices extends ChangeNotifier {
  final String statusKey = 'loginStatus';
  final String userKey = 'userId';
  User? _currentUser;

  final _db = AppDatabase.instance;
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  Future<bool> isUserLoggedIn() async {
    if (_instance == null) {
      await init();
    }

    return _instance!.getBool(statusKey) ?? false;
  }

  Future<bool> registerUser(User newUser) async {
    await _db.insertUser(newUser.toJson());

    notifyListeners();
    return true;
  }

  Future<bool> loginUser(String email, String password) async {
    final user = await _db.readUser(email, password);

    if (_instance != null && user != null) {
      await _instance!.setBool(statusKey, true);
      await _instance!.setString(userKey, user.id);
      _currentUser = user;
      return true;
    } else {
      return false;
    }
  }

  Future<User?> get user async {
    _currentUser ??= await _db.getCurrentUser(_instance!.getString(userKey)!);
    return _currentUser;
  }

  Future<void> signOut() async {
    if (_instance == null) {
      await init();
    }
    _instance!.remove(userKey);
    _instance!.remove(statusKey);
  }
}
