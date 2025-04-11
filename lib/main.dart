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

// TODO: shared_preferencesでチェックボックス機能の実装

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerAsync = ref.watch(routerProvider);
    // routerをasyncで作ったので必要
    return routerAsync.when(
      data: (router) {
        return MaterialApp.router(
          title: 'Go Router Sample',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true,
          ),
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, stack) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('エラー: $error')),
        ),
      ),
    );
  }
}