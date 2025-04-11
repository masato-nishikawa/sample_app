import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
// pageのインポート
import 'package:sample_app/pages/home_page.dart';
import 'package:sample_app/pages/my_page.dart';
import 'package:sample_app/pages/tab_page.dart';
import 'package:sample_app/pages/test_page.dart';
import 'package:sample_app/pages/add_page.dart';
import 'package:sample_app/pages/detail_page.dart';
// providersのインポート
//import 'package:sample_app/providers/tab_providers.dart';

//　アプリの基本設計として変更しない部分
final defaultPagesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'name': 'home',
      'path': '/',
      'builder': (context, state) => HomePage(title: 'テストアプリ'),
    },
    // タブとホームは下で統一
  ];
});

// Riverpodでデータを読み込む様に変更予定
final addithonalPagesProvider = StateProvider<List<Map<String, dynamic>>>((ref,) {
  return [
    {
      'name': 'test',
      'path': '/test',
      'builder': (context, state) => const TestPage(),
    },
    {
      'name': 'about',
      'path': '/about',
      'builder': (context, state) => const AboutPage(),
    },
    {
      'name': 'settings',
      'path': '/settings',
      'builder': (context, state) => const SettingsPage(),
    },
  ];
});

//　ユーザー情報の入力画面の部分
final addPagesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'name': 'addName',
      //　pathの/は消す
      'path': 'addName',
      'builder': (context, state) => const AddPageName(),
    },
    {
      'name': 'prefecture',
      'path': 'prefecture',
      'builder': (context, state) => const AddPagePrefecture(),
    },
    {
      'name': 'gender',
      'path': 'gender',
      'builder': (context, state) => const AddPageGender(),
    },
    {
      'name': 'birthday',
      'path': 'birthday',
      'builder': (context, state) => const AddPageBirthday(),
    },
    {
      'name': 'homegelande',
      'path': 'homegelande',
      'builder': (context, state) => const AddPageGelande(),
    },
    {
      'name': 'my_board',
      'path': 'my_board',
      'builder': (context, state) => const AddPageMyBoard(),
    },
  ];
});

// CSVからトリックの一覧を取得
final tricksPageprovider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final mainCsv = await rootBundle.loadString('assets/csv/main_data.csv');
  final mainCsvTable = const CsvToListConverter().convert(mainCsv);
  final List<Map<String, dynamic>>  tricksList = [];
  for (final row in mainCsvTable) {
    if (row.length > 1 ) {
      final map = {
        'name': row[3],
        'path': row[3],
        'builder': (context, state) => DetailPage(trickName: row[2]),
      };
      tricksList.add(map);
    }
  }
  return tricksList;
});

// routerを統一
final routerProvider = FutureProvider<GoRouter>((ref) async {
  final defaultPages = ref.read(defaultPagesProvider);
  final additionalPages = ref.read(addithonalPagesProvider);
  final addPages = ref.read(addPagesProvider);
  final tricksPages = await ref.watch(tricksPageprovider.future);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      ...defaultPages.map(
        (page) => GoRoute(
          name: page['name'] as String,
          path: page['path'] as String,
          builder: page['builder'] as GoRouterWidgetBuilder,
        ),
      ),
      ...additionalPages.map(
        (page) => GoRoute(
          name: page['name'] as String,
          path: page['path'] as String,
          builder: page['builder'] as GoRouterWidgetBuilder,
        ),
      ),
      // 入れ子化したいのでこっちで直接書くがよく出来そう
      GoRoute(
        name: 'mypage',
        path: '/mypage',
        builder: (context, state) => const MyPage(),
        routes: [
          ...addPages.map(
            (page) => GoRoute(
              name: page['name'] as String,
              path: page['path'] as String,
              builder: page['builder'] as GoRouterWidgetBuilder,
            ),
          ),
        ],
      ),
      GoRoute(
        name: 'tab',
        path: '/tab',
        builder: (context, state) => const TabPage(),
        routes: [
          ...tricksPages.map(
            (page) => GoRoute(
              name: page['name'] as String,
              path: page['path'] as String,
              builder: page['builder'] as GoRouterWidgetBuilder,
            ),
          ),
        ],
      ),
    ],
  );
});