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



final birthdayProvider = FutureProvider<String>((ref) async{
  final prefs = await SharedPreferences.getInstance();
  const key = 'birthday';
   // 値がなければ初期値を保存
  if (!prefs.containsKey(key)) {
    await prefs.setString(key, '');
  }
  return prefs.getString(key)!;
});

final genderProvider = FutureProvider<String>((ref) async{
  final prefs = await SharedPreferences.getInstance();
  const key = 'gender';
   // 値がなければ初期値を保存
  if (!prefs.containsKey(key)) {
    await prefs.setString(key, '');
  }
  return prefs.getString(key)!;
});

final prefectureProvider = FutureProvider<String>((ref) async{
  final prefs = await SharedPreferences.getInstance();
  const key = 'prefecture';
   // 値がなければ初期値を保存
  if (!prefs.containsKey(key)) {
    await prefs.setString(key, '');
  }
  return prefs.getString(key)!;
});

final homegelandeProvider = FutureProvider<String>((ref) async{
  final prefs = await SharedPreferences.getInstance();
  const key = 'homegelande';
   // 値がなければ初期値を保存
  if (!prefs.containsKey(key)) {
    await prefs.setString(key, '');
  }
  return prefs.getString(key)!;
});