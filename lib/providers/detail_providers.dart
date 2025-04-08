import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:csv/csv.dart';


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

final youtubeLinkProvider = FutureProvider.family<String, String>(
  (ref, trick) async {
    final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
    final mainCsvTable = const CsvToListConverter().convert(mainCsv);
    // カテゴリ名に一致するのを抜き出す
    for (final row in mainCsvTable) {
      if (row[2] == trick) {
        return row[26].toString();
        
      }
    }
    throw Exception('動画が見つかりません');
  });

final trickFlowProvider = FutureProvider.family<List<dynamic>, String>(
  (ref, trick) async {
    final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
    final mainCsvTable = const CsvToListConverter().convert(mainCsv);
    final List<dynamic> list = [];
    // カテゴリ名に一致するのを抜き出す
    for (final row in mainCsvTable) {
      if (row.length > 1 && row[2] == trick) {
        for (int i = 6; i < 15; ++i ){
          if (row[i] != ''){
            list.add(row[i]);
          }
        }
      }
    }
    return list;
  });

final settingsProvider = FutureProvider.family<List<List<dynamic>>, String>(
  (ref, trick) async {
    final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
    final mainCsvTable = const CsvToListConverter().convert(mainCsv);
    final List<List<dynamic>> list = [];
    // カテゴリ名に一致するのを抜き出す
    for (final row in mainCsvTable) {
      if (row.length > 1 && row[2] == trick) {
        for (int i = 16; i < 25; i += 2 ){
          if (row[i] != ''){
            list.add([row[i],row[i+1]]);
          }
        }
      }
    }
    print(list);
    return list;
  });