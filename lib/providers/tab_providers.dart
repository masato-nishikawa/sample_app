import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:csv/csv.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tabsProvider = Provider<List<List<String>>>((ref) {
  return [
    ['弾き系', 'assets/icons/tab1.png'],
    ['バター系', 'assets/icons/tab2.png'],
    ['カービング', 'assets/icons/tab3.png'],
    ['ハーフパイプ', 'assets/icons/tab4.png'],
    ['キッカー', 'assets/icons/tab5.png'],
    ['ジブ', 'assets/icons/tab6.png'],
    ['バックカントリー', 'assets/icons/tab7.png'],
    ['メンテナンス', 'assets/icons/tab8.png'],
  ];
});

// カテゴリ別にCSVのリストを返すように変更
final categoryProvider = FutureProvider.family<List<List<dynamic>>, String>(
  (ref, category) async {
    final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
    final mainCsvTable = const CsvToListConverter().convert(mainCsv);
    final List<List<dynamic>> list = [];
    // カテゴリ名に一致するのを抜き出す
    for (final row in mainCsvTable) {
      if (row.length > 1 && row[1] == category) {
        list.add(row);
      }
    }
    return list;
  });

// カテゴリ別にCSVのリストを返すように変更
final trickProvider = FutureProvider.family<List<List<dynamic>>, String>(
  (ref, trick) async {
    final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
    final mainCsvTable = const CsvToListConverter().convert(mainCsv);
    final List<List<dynamic>> list = [];
    // カテゴリ名に一致するのを抜き出す
    for (final row in mainCsvTable) {
      if (row.length > 1 && row[2] == trick) {
        list.add(row);
      }
    }
    return list;
  });


class CheckboxNotifier extends FamilyAsyncNotifier<bool, String> {
  // build内で値を入れたい時はlateをつける
  late final String trick;

  @override
  Future<bool> build(String trick) async {
    // ファミリーパラメータで渡された文字列を内部に保持
    // プロバイダー内にマップのように個別に状態を持たせたい場合に必要
    this.trick = trick;
    final prefs = await SharedPreferences.getInstance();
    final key = '${trick}_checkbox';
    // キーが存在しなければ初期値を false に設定
    if (!prefs.containsKey(key)) {
      await prefs.setBool(key, false);
    }
    return prefs.getBool(key) ?? false;
  }

  // チェックボックスの状態を更新するメソッド
  Future<void> updateCheckbox(bool newState) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${trick}_checkbox';
    await prefs.setBool(key, newState);
    // 状態を新しい値に更新
    state = AsyncValue.data(newState);
  }
}


// AsyncNotifierProviderでUserNotifierを公開
final checkboxProvider = AsyncNotifierProvider.family<CheckboxNotifier, bool, String>(
  () => CheckboxNotifier(),
);