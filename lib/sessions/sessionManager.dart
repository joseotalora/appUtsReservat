import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

class SessionManager {
  static final SessionManager _sessionManager = SessionManager._internal();

  factory SessionManager() {
    return _sessionManager;
  }

  late SharedPreferences _prefs;
  SessionManager._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // token
  String get token {
    return _prefs.getString(KEY_TOKEN) ?? '';
  }

  set token(String value) {
    String tag = 'Bearer ';
    _prefs.setString(KEY_TOKEN, '$tag$value');
  }

  // user id
  int get ownerId {
    return _prefs.getInt(KEY_USER_ID) ?? 0;
  }

  set ownerId(int value) {
    _prefs.setInt(KEY_USER_ID, value);
  }

  // delete app data saved in preferences of mobile
  void deleteAll() {
    _prefs.clear();
  }
}
