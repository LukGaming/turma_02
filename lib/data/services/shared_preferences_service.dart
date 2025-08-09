import 'package:shared_preferences/shared_preferences.dart';
import 'package:turma_02/data/services/models/user/preferences_keys.dart';
import 'package:turma_02/domain/models/user.dart';
import 'package:turma_02/utils/result.dart';

class SharedPreferencesService {
  Future<Result<void>> saveUser(User user) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      preferences.setString(PreferencesKeys.userKey, user.toJson());
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<User?>> getUser() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final user = preferences.getString(PreferencesKeys.userKey);
      print("User inside shared: $user");
      if (user != null) {
        return Result.ok(User.fromJson(user));
      }
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<void>> clear() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      preferences.clear();
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
