import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class SharedPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String keyUser = 'keyUser';
  final String keyCheckLogin = 'keyCheckLogin';
  final String keyCheckFirstLogin = 'keyCheckFirstLogin';

  Future<UserModel?> getUser() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString(keyUser); // lấy dữ liệu ra thông qua key
    if (data == null) return null;

    print('object $data');

    Map<String, dynamic> map = jsonDecode(data); // biến string thành Map

    print('object $map');

    UserModel user = UserModel.fromJson(map);
    return user;
  }

  Future<void> saveUser(UserModel user) async {
    SharedPreferences prefs = await _prefs;
    Map<String, dynamic> map = user.toJson();
    // NOTE
    prefs.setString(keyUser, jsonEncode(map)); // biến Map thành string
  }

  Future<bool?> getKeyCheck() async {
    SharedPreferences prefs = await _prefs;
    bool? isLogin = prefs.getBool(keyCheckLogin);
    if (isLogin == null) return false;
    return isLogin;
  }

  Future<void> saveKeyCheck() async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(keyCheckLogin, false);
  }

    Future<bool?> getKeyCheckFirstLogin() async {
    SharedPreferences prefs = await _prefs;
    bool? isFirstLogin = prefs.getBool(keyCheckFirstLogin);
    if (isFirstLogin == null) return false;
    return isFirstLogin;
  }

  Future<void> saveKeyCheckFirstLogin() async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(keyCheckFirstLogin, true);
  }

  Future<void> removeAll() async {
    SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
  
}
