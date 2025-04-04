import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ユーザー名を非同期で管理するNotifier
class UserNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'username';
    // キーが存在しなければ初期値として空文字を設定
    if (!prefs.containsKey(key)) {
      await prefs.setString(key, '');
    }
    return prefs.getString(key)!;
  }

  /// ユーザー名を更新するメソッド
  Future<void> updateUsername(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newName);
    // 状態を新しい値に更新
    state = AsyncValue.data(newName);
  }

  /// ユーザー名をリセットするメソッド
  Future<void> resetUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final userProvider = AsyncNotifierProvider<UserNotifier, String>(() => UserNotifier());


/// ユーザー名を非同期で管理するNotifier
class PrefectureNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'prefecture';
    // キーが存在しなければ初期値として空文字を設定
    if (!prefs.containsKey(key)) {
      await prefs.setString(key, '');
    }
    return prefs.getString(key)!;
  }

  /// ユーザー名を更新するメソッド
  Future<void> updatePrefecture(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('prefecture', newName);
    // 状態を新しい値に更新
    state = AsyncValue.data(newName);
  }

  /// ユーザー名をリセットするメソッド
  Future<void> resetPrefecture() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('prefecture', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final prefectureProvider = AsyncNotifierProvider<PrefectureNotifier, String>(() => PrefectureNotifier());


/// ユーザー名を非同期で管理するNotifier
class GenderNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'gender';
    // キーが存在しなければ初期値として空文字を設定
    if (!prefs.containsKey(key)) {
      await prefs.setString(key, '');
    }
    return prefs.getString(key)!;
  }

  /// ユーザー名を更新するメソッド
  Future<void> updateGender(String newState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', newState);
    // 状態を新しい値に更新
    state = AsyncValue.data(newState);
  }

  /// ユーザー名をリセットするメソッド
  Future<void> resetGender() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final genderProvider = AsyncNotifierProvider<GenderNotifier, String>(() => GenderNotifier());


/// ユーザー名を非同期で管理するNotifier
class BirthdayNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'birthday';
    // キーが存在しなければ初期値として空文字を設定
    if (!prefs.containsKey(key)) {
      await prefs.setString(key, '');
    }
    return prefs.getString(key)!;
  }

  /// ユーザー名を更新するメソッド
  Future<void> updateBirthday(String newState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday', newState);
    // 状態を新しい値に更新
    state = AsyncValue.data(newState);
  }

  /// ユーザー名をリセットするメソッド
  Future<void> resetBirthday() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final birthdayProvider = AsyncNotifierProvider<BirthdayNotifier, String>(() => BirthdayNotifier());


/// ユーザー名を非同期で管理するNotifier
class GelandeNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'gelande';
    // キーが存在しなければ初期値として空文字を設定
    if (!prefs.containsKey(key)) {
      await prefs.setString(key, '');
    }
    return prefs.getString(key)!;
  }

  /// ユーザー名を更新するメソッド
  Future<void> updateGelande(String newState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gelande', newState);
    // 状態を新しい値に更新
    state = AsyncValue.data(newState);
  }

  /// ユーザー名をリセットするメソッド
  Future<void> resetGelande() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gelande', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final gelandeProvider = AsyncNotifierProvider<GelandeNotifier, String>(() => GelandeNotifier());

