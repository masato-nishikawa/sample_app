import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ファイルのインポート
import 'package:sample_app/providers.dart';

final routerProvider = StateProvider<GoRouter>((ref) {
  final routerPages = [
    ...ref.watch(defaultPagesProvider),
    ...ref.watch(addithonalPagesProvider),
  ];

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
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
