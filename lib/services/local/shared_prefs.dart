import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/questions.dart';
import '../../models/user_model.dart';

class SharedPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String keyUser = 'keyUser';
  final String keyCheckLogin = 'keyCheckLogin';
  final String keyCheckFirstLogin = 'keyCheckFirstLogin';
  final String keyNumOfPlays = 'keyNumOfPlays';
  final String keyNewQuestions = 'keyNewQuestions';

  Future<UserModel?> getUser() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString(keyUser);
    if (data == null) return null;

    // print('object $data');

    Map<String, dynamic> map = jsonDecode(data);

    // print('object $map');

    UserModel user = UserModel.fromJson(map);
    return user;
  }

  Future<void> saveUser(UserModel user) async {
    SharedPreferences prefs = await _prefs;
    Map<String, dynamic> map = user.toJson();
    // NOTE
    prefs.setString(keyUser, jsonEncode(map));
  }

  Future<bool?> getKeyCheck() async {
    SharedPreferences prefs = await _prefs;
    bool? isLogin = prefs.getBool(keyCheckLogin);
    // print(isLogin);
    if (isLogin == null) return false;
    return isLogin;
  }

  Future<void> saveKeyCheck(bool isLogin) async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(keyCheckLogin, isLogin);
  }

  Future<bool?> getKeyCheckFirstLogin() async {
    SharedPreferences prefs = await _prefs;
    bool? isFirstLogin = prefs.getBool(keyCheckFirstLogin);
    if (isFirstLogin == null) return true;
    return isFirstLogin;
  }

  Future<void> saveKeyCheckFirstLogin() async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(keyCheckFirstLogin, false);
  }

  Future<void> removeAll() async {
    SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  Future<void> saveNumOfPlays() async {
    SharedPreferences prefs = await _prefs;
    int currentNumOfPlays = prefs.getInt(keyNumOfPlays) ?? 0;
    int newNumOfPlays = currentNumOfPlays + 1;
    prefs.setInt(keyNumOfPlays, newNumOfPlays);
  }

  Future<int?> getNumOfPlays() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getInt(keyNumOfPlays);
  }

  Future<List<Question>?> getQuestions() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString(keyNewQuestions);
    if (data == null) return null;

    // print('object $data');

    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    // print('object $maps');
    return maps.map((e) => Question.fromJson(e)).toList();
  }

  Future<void> saveQuestions(List<Question> questions) async {
    SharedPreferences prefs = await _prefs;
    List<Map<String, dynamic>> maps = questions.map((e) => e.toJson()).toList();
    prefs.setString(keyNewQuestions, jsonEncode(maps));
  }
}
