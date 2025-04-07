import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// pageのインポート
import 'package:sample_app/pages/home_page.dart';
import 'package:sample_app/pages/my_page.dart';
import 'package:sample_app/pages/tab_page.dart';
import 'package:sample_app/pages/test_page.dart';
import 'package:sample_app/pages/add_page.dart';

//　アプリの基本設計として変更しない部分
final defaultPagesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'name': 'home',
      'path': '/',
      'builder': (context, state) => HomePage(title: 'テストアプリ'),
    },
    {
      'name': 'tab',
      'path': '/tab',
      'builder': (context, state) => const TabPage(),
    },
    // {
    //   'name': 'mypage',
    //   'path': '/mypage',
    //   'builder': (context, state) => const MyPage(),
    // },
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


final routerProvider = StateProvider<GoRouter>((ref) {
  final defaultPages = ref.watch(defaultPagesProvider);
  final additionalPages = ref.watch(addithonalPagesProvider);
  final addPages = ref.watch(addPagesProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
    // ...でリストを展開しているからmap操作が出来ちる
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
      GoRoute(
        name: 'mypage',
        path: '/mypage',
        builder: (context, state) => const MyPage(),
        routes: [
          // addPagesをmypageの子ルートとして展開
          ...addPages.map(
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