import 'package:expense_management_app/models/user_model.dart';
import 'package:expense_management_app/services/boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuth with ChangeNotifier {
  static const String _loginKey = 'isloggedin';
  static const String _userKey = 'userId';

  final Box<User>? _box = Boxes.getUserBox();
  late User currentUser;
  static SharedPreferences? _preferences;

  static Future<void> setupUsers() async {
    await Hive.openBox<User>('user');
  }

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> registerUser(User newUser) async {
    if (_box == null) {
      await setupUsers();
    }
    newUser.joinedAt = DateTime.now();
    await _box!.add(newUser);
    notifyListeners();
    return true;
  }

  Future<bool> isUserLoggedIn() async {
    if (_preferences != null) {
      return _preferences!.getBool('isloggedin') ?? false;
    }
    return false;
  }

  Future<bool> setCurrentUser() async {
    final String userId = _preferences!.getString('userId')!;
    for (var user in _box!.values) {
      if (user.id == userId) {
        currentUser = user;
        return true;
      }

      return false;
    }
    return false;
  }

  Future<bool> loginUser(String email, String password) async {
    for (var user in _box!.values) {
      if (user.email == email && user.password == password) {
        await setLoginState(true, user.id);
        return true;
      }
    }
    return false;
  }

  Future<void> setLoginState(bool loginStatus, String userId) async {
    await _preferences!.setBool(_loginKey, loginStatus);
    await _preferences!.setString(_userKey, userId);
  }

  Future<bool> logoutUser() async {
    await _preferences!.remove(_loginKey);
    await _preferences!.remove(_userKey);
    return true;
  }

  List<({int month, int year})> userJoinedPeriod() {
    DateTime joinningDate = currentUser.joinedAt;

    List<({int month, int year})> dateList = [];

    final duration = DateTimeRange(start: joinningDate, end: DateTime.now());

    int yy = duration.start.year;

    while (yy <= duration.end.year) {
      if (yy == duration.end.year) {
        int mm = duration.start.month;
        while (mm <= duration.end.month) {
          dateList.add((month: mm, year: yy));
          mm += 1;
        }
      } else {
        int mm = 1;
        while (mm <= 12) {
          dateList.add((month: mm, year: yy));
          mm += 1;
        }
      }
      yy += 1;
    }
    dateList.forEach(print);
    return dateList;
  }
}
