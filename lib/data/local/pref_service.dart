import 'package:formula/res/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static late SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  setRegId(String regId) {
    return setString(AppStrings.regIdKey, regId);
  }
  setThemeMode(bool isDarkMode) {
    return setBool(AppStrings.themeKey, isDarkMode);
  }

  getThemeMode() {
    return getBool(AppStrings.themeKey);
  }
  getRegId() {
    return getString(AppStrings.regIdKey);
  }

  setMobile(String mobile) {
    return setString(AppStrings.mobileNoKey, mobile);
  }

  getMobile() {
    return getString(AppStrings.mobileNoKey);
  }

  Future<bool> setToken(String token) {
    return setString(AppStrings.tokenKey, token);
  }

  getToken() {
    return getString(AppStrings.tokenKey);
  }

  setNotification(String notification) {
    return setString(AppStrings.notificationIdKey, notification);
  }

  getNotification() {
    return getString(AppStrings.notificationIdKey);
  }

  ///sets
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  ///gets
  static bool? getBool(String key) => _prefs.getBool(key);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static int? getInt(String key) => _prefs.getInt(key);

  static String? getString(String key) => _prefs.getString(key);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  ///deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();

  // Store attempted quiz ID in shared preferences
  static void storeAttemptedQuizId(String quizId) async {
    List<String>? attemptedQuizzes =
        _prefs.getStringList('attemptedQuizzes') ?? [];

    // Add new quiz ID if it's not already in the list
    if (!attemptedQuizzes.contains(quizId.toString())) {
      attemptedQuizzes.add(quizId.toString());
      await _prefs.setStringList('attemptedQuizzes', attemptedQuizzes);
    }
  }

  // Check if quiz is attempted
  static bool isQuizAttempted(String quizId) {
    List<String>? attemptedQuizzes =
        _prefs.getStringList('attemptedQuizzes') ?? [];

    return attemptedQuizzes.contains(quizId.toString());
  }

  // Store question in shared preferences
  static void storeBookmarkQuestionId(String questionId) async {
    List<String>? bookmarkedQuestions =
        _prefs.getStringList('bookmarkedQuestions') ?? [];

    // Add new quiz ID if it's not already in the list
    if (!bookmarkedQuestions.contains(questionId.toString())) {
      bookmarkedQuestions.add(questionId.toString());
      await _prefs.setStringList('bookmarkedQuestions', bookmarkedQuestions);
    }
  }

  // Remove question from shared preferences
  static void removeBookmarkQuestionId(String questionId) async {
    List<String>? bookmarkedQuestions =
        _prefs.getStringList('bookmarkedQuestions') ?? [];

    bookmarkedQuestions.remove(questionId.toString());
    await _prefs.setStringList('bookmarkedQuestions', bookmarkedQuestions);
  }

  // Check if question is bookmarked
  static bool isQuestionBookmarked(String questionId) {
    List<String>? bookmarkedQuestions =
        _prefs.getStringList('bookmarkedQuestions') ?? [];

    return bookmarkedQuestions.contains(questionId.toString());
  }

  // Get bookmarked questions
  static dynamic getBookmarkedQuestions() {
    return getStringList('bookmarkedQuestions');
  }
}
