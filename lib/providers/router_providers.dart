import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// pageのインポート
import 'package:sample_app/pages/home_page.dart';
import 'package:sample_app/pages/my_page.dart';
import 'package:sample_app/pages/tab_page.dart';
import 'package:sample_app/pages/test_page.dart';

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
    {
      'name': 'mypage',
      'path': '/mypage',
      'builder': (context, state) => const MyPage(),
    },
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

final routerProvider = StateProvider<GoRouter>((ref) {
  final routerPages = [
    ...ref.watch(defaultPagesProvider),
    ...ref.watch(addithonalPagesProvider),
  ];

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
    // ...でリストを展開しているからmap操作が出来ちる
      ...routerPages.map(
        (page) => GoRoute(
          name: page['name'] as String,
          path: page['path'] as String,
          builder: page['builder'] as GoRouterWidgetBuilder,
        ),
      ),
    ],
  );
});