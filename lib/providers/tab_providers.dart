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

// TODO: クラス化してカテゴリ名で定義が出来るようにしたい
final flipProvider = FutureProvider<List<List<dynamic>>>((ref) async {
  final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
  final mainCsvTable = const CsvToListConverter().convert(mainCsv);
  final List<List<dynamic>>  flipList = [];
  for (final row in mainCsvTable) {
    if (row.length > 1 && row[1] == '弾き系') {
        flipList.add(row);
    }
  }
  return flipList;
});

final butterProvider = FutureProvider<List<List<dynamic>>>((ref) async {
  final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
  final mainCsvTable = const CsvToListConverter().convert(mainCsv);
  final List<List<dynamic>>  butterList = [];
  for (final row in mainCsvTable) {
    if (row.length > 1 && row[1] == 'バター系') {
        butterList.add(row);
    }
  }
  return butterList;
});

final carvingProvider = FutureProvider<List<List<dynamic>>>((ref) async {
  final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
  final mainCsvTable = const CsvToListConverter().convert(mainCsv);
  final List<List<dynamic>>  carvingList = [];
  for (final row in mainCsvTable) {
    if (row.length > 1 && row[1] == 'カービング') {
        carvingList.add(row);
    }
  }
  return carvingList;
});
