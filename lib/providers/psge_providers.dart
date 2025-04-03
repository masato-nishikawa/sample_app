import 'package:flutter_riverpod/flutter_riverpod.dart';
// pageのインポート
import 'package:sample_app/pages/home_page.dart';
import 'package:sample_app/pages/my_page.dart';
import 'package:sample_app/pages/test_page.dart';

final defaultPagesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      'name': 'home',
      'path': '/',
      'builder': (context, state) => MyHomePage(title: 'test'),
    },
    {
      'name': 'mypage',
      'path': '/mypage',
      'builder': (context, state) => const MyPage(),
    },
  ];
});

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
