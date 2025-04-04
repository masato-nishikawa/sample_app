import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// プロバイダーのインポート
import 'package:sample_app/providers/mypage_providers.dart';

/// マイページの表示用Widget
class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    // 非同期状態のユーザー名を監視
    final usernameAsync = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text('マイページ'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'リセット',
              onPressed: () {
                ref.read(userProvider.notifier).resetUsername();
              },
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 名前表示と編集ボタンのRow
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    '名前:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // 非同期状態に基づくユーザー名の表示
                  usernameAsync.when(
                    data: (value) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value.isEmpty ? '名前が設定されていません。' : value,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (err, _) => Text('エラーが発生しました: $err'),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      // 名前編集画面へ遷移し、結果を受け取る
                      final result = await context.push<String>('/addname');
                      if (result != null ) {
                        await ref.read(userProvider.notifier).updateUsername(result);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}