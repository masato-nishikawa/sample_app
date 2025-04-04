import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// dartファイルのインポート
import 'package:sample_app/providers/router_providers.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp()
    )
  );
}

// TODO: csvとshared_preferencesのデータ保持
// TODO: ref watchとreadの使い分け


class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      // MaterialApp.routerなので注意
      title: 'Go Router Sample',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      // 以下３行を追加
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
