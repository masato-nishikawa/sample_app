import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// pageのインポート
import 'package:sample_app/pages/home_page.dart';
import 'package:sample_app/pages/my_page.dart';
import 'package:sample_app/pages/test_page.dart';

final pages = [
  {'path': '/', 'builder': (context, state) => const TestPage()},
  {'path': '/about', 'builder': (context, state) => const AboutPage()},
  {'path': '/settings', 'builder': (context, state) => const SettingsPage()},
];

final router = GoRouter(
  // go-routerのルート構造を表示してくれる
  debugLogDiagnostics: true,
  // go-routerの初期画面
  initialLocation: '/',
  // ルート構造の具体的な内容
  routes: [
    // 固定したいルートの部分
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => MyHomePage(title: 'test'),
    ),
    GoRoute(
      name: 'mypage',
      path: '/mypage',
      builder: (context, state) => MyPage(),
    ),
    // 動的にしたいルート部分
    ...pages.map(
      (page) => GoRoute(
        path: page['path'] as String,
        builder: page['builder'] as GoRouterWidgetBuilder,
      ),
    ),
  ],
);
