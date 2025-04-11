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

class CheckboxNotifier extends AsyncNotifier{

  @override
  Future<String> build() async {
    final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
    final mainCsvTable = const CsvToListConverter().convert(mainCsv);
    final prefs = await SharedPreferences.getInstance();
    for (final row in mainCsvTable){
      String key = '${row[1]}_chevkbox';

    // キーが存在しなければ初期値として空文字を設定
    if (!prefs.containsKey(key)) {
      await prefs.setString(key, false);
    }
    return prefs.getString(key)!;
    }
  }

  // チェックボックスを更新するメソッド
  Future<void> updateUsername(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newName);
    // 状態を新しい値に更新
    state = AsyncValue.data(newName);
  }

}


// AsyncNotifierProviderでUserNotifierを公開
final checkboxProvider = AsyncNotifierProvider<CheckboxNotifier, String>(() => CheckboxNotifier());