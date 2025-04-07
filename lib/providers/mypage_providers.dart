import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ユーザー名を非同期で管理するNotifier
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

  // ユーザー名を更新するメソッド
  Future<void> updateUsername(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newName);
    // 状態を新しい値に更新
    state = AsyncValue.data(newName);
  }

  // ユーザー名をリセットするメソッド
  Future<void> resetUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final userProvider = AsyncNotifierProvider<UserNotifier, String>(() => UserNotifier());


// 都道府県を非同期で管理するNotifier
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

  // 都道府県を更新するメソッド
  Future<void> updatePrefecture(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('prefecture', newName);
    // 状態を新しい値に更新
    state = AsyncValue.data(newName);
  }

  // 都道府県をリセットするメソッド
  Future<void> resetPrefecture() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('prefecture', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final prefectureProvider = AsyncNotifierProvider<PrefectureNotifier, String>(() => PrefectureNotifier());


// 性別を非同期で管理するNotifier
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

  // 性別を更新するメソッド
  Future<void> updateGender(String newState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', newState);
    // 状態を新しい値に更新
    state = AsyncValue.data(newState);
  }

  // 性別をリセットするメソッド
  Future<void> resetGender() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final genderProvider = AsyncNotifierProvider<GenderNotifier, String>(() => GenderNotifier());


// 誕生日を非同期で管理するNotifier
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

  // 誕生日を更新するメソッド
  Future<void> updateBirthday(String newState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday', newState);
    // 状態を新しい値に更新
    state = AsyncValue.data(newState);
  }

  // 誕生日をリセットするメソッド
  Future<void> resetBirthday() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final birthdayProvider = AsyncNotifierProvider<BirthdayNotifier, String>(() => BirthdayNotifier());


// ホームゲレンデを非同期で管理するNotifier
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

  /// ホームゲレンデを更新するメソッド
  Future<void> updateGelande(String newState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gelande', newState);
    // 状態を新しい値に更新
    state = AsyncValue.data(newState);
  }

  /// ホームゲレンデをリセットするメソッド
  Future<void> resetGelande() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gelande', '');
    // 状態を新しい値に更新
    state = AsyncValue.data('');
  }
}
// AsyncNotifierProviderでUserNotifierを公開
final gelandeProvider = AsyncNotifierProvider<GelandeNotifier, String>(() => GelandeNotifier());


// マイボードを非同期で管理するNotifierでJSONの処理が追加されたもの
class MyBoardNotifier extends AsyncNotifier<List<List<String>>> {
  @override
  Future<List<List<String>>> build() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'myBoard';
    // キーが存在しなければ初期値を設定（空の2次元リスト）
    if (!prefs.containsKey(key)) {
      final emptyJson = jsonEncode(<List<String>>[]);
      await prefs.setString(key, emptyJson);
    }
    final jsonString = prefs.getString(key)!;
    // JSON文字列 → List<List<String>>
    final List<dynamic> decoded = jsonDecode(jsonString);
    final List<List<String>> result = decoded.map<List<String>>(
      (row) => List<String>.from(row),
    ).toList();
    return result;
  }

  // マイボードを更新するメソッド
Future<void> updateMyBoard(List<List<String>> newItems) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'myBoard';
  // 既存データを読み込む（なければ空リスト）
  final jsonString = prefs.getString(key);
  List<List<String>> current = [];
  if (jsonString != null) {
    final decoded = jsonDecode(jsonString) as List<dynamic>;
    current = decoded.map<List<String>>((row) => List<String>.from(row)).toList();
  }
  // 追加
  final updated = [...current, ...newItems];
  // 保存
  final updatedJson = jsonEncode(updated);
  await prefs.setString(key, updatedJson);
  // 状態を更新
  state = AsyncValue.data(updated);
}

  // マイボードを更新するメソッド
  Future<void> resetMyBoard() async {
    final prefs = await SharedPreferences.getInstance();
    // 状態管理とprefsの処理の２つがある
    final emptyData = <List<String>>[];
    // prefsに入れる処理
    final emptyJson = jsonEncode(emptyData);
    await prefs.setString('myBoard', emptyJson);
    // 状態を新しい値に更新
    state = AsyncValue.data(emptyData);
  }
}

final myBoardProvider =
    AsyncNotifierProvider<MyBoardNotifier, List<List<String>>>(() => MyBoardNotifier());