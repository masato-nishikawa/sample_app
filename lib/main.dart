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
          // ルーティングの情報をデバックコンソールに提供してくれる
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


// TODO: これからやるべき事
// FIXME: 今は動いているけど本当は直したい
// HACK: 一時的な回避・ダーティな実装

// NOTE: 注意点や補足情報
// BUG: 確認済みバグや再現手順など