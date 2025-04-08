import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:csv/csv.dart';

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

