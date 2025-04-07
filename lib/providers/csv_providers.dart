import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:csv/csv.dart';

// csvを読み込むので非同期のRiverpodを使ってみる

// タブのリストになる部分の読み込み
final mainCsvProvider = FutureProvider<List<List<dynamic>>>((ref) async {
   // ロードサークルの確認のために1秒待機させる
  await Future.delayed(const Duration(seconds: 2));
  // アセットにあるcsvを読み込む
  final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
  // 読み込んだcsvをリストに変化する（ヘッダーを含む）
  final mainCsvTable = const CsvToListConverter().convert(mainCsv);
  return mainCsvTable;
});

// マイページでメーカーを設定する部分の読み込み
final makerCsvProvider = FutureProvider<Map<String, List<dynamic>>>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  final makerCsv = await rootBundle.loadString('assets/csv/maker_data.csv');
  final makerCsvTable = const CsvToListConverter().convert(makerCsv);
  final boardMaker = makerCsvTable
      .skip(1) // ヘッダーを除く
      .map((row) => row[1])
      .toList();
    final bindingMaker = makerCsvTable
      .skip(1) // ヘッダーを除く
      .map((row) => row[2])
      .toList();
    final bootsMaker = makerCsvTable
      .skip(1) // ヘッダーを除く
      .map((row) => row[3])
      .toList();
    return {
    'board': boardMaker,
    'binding': bindingMaker,
    'boots': bootsMaker,
  };
});

