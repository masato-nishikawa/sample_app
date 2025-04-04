import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// プロバイダーのインポート
import 'package:sample_app/providers/mypage_providers.dart';

// TODO: 未設定の文字位置がズレる

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
    final prefectureAsync = ref.watch(prefectureProvider);
    final genderAsync = ref.watch(genderProvider);
    final birthdayAsync = ref.watch(birthdayProvider);
    final gelandeAsync = ref.watch(gelandeProvider);


// TODO: Pddingについて見やすくしたい
    return Scaffold(
      appBar: AppBar(
          title: const Text('マイページ'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'リセット',
              onPressed: () {
                ref.read(userProvider.notifier).resetUsername();
                ref.read(prefectureProvider.notifier).resetPrefecture();
                ref.read(genderProvider.notifier).resetGender();
                ref.read(birthdayProvider.notifier).resetBirthday();
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
              // 上下に対象の余白を挿入している
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text('名前:',
                    // フォントサイズと太線の指定
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // 非同期状態に基づくユーザー名の表示
                  usernameAsync.when(
                    // ロード完了後に表示させるデータ
                    data: (value) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value.isEmpty ? '未設定' : value,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                    // ロード中はクルクルを表示させる
                    loading: () => const CircularProgressIndicator(),
                    // エラー時のメッセージ表示
                    error: (err, _) => Text('エラーが発生しました: $err'),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      // 名前編集画面へ遷移し、結果を受け取る
                      final result = await context.push<String>('/addname');
                      // 受け取った結果に対してnotifierでアップデートをかける
                      if (result != null ) {
                        await ref.read(userProvider.notifier).updateUsername(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    '都道府県:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // 非同期状態に基づくユーザー名の表示
                  prefectureAsync.when(
                    data: (value) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value.isEmpty ? '未設定' : value,
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
                      final result = await context.push<String>('/prefecture');
                      if (result != null ) {
                        await ref.read(prefectureProvider.notifier).updatePrefecture(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    '性別:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // 非同期状態に基づくユーザー名の表示
                  genderAsync.when(
                    data: (value) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value.isEmpty ? '未設定' : value,
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
                      final result = await context.push<String>('/gender');
                      if (result != null ) {
                        await ref.read(genderProvider.notifier).updateGender(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    '誕生日:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // 非同期状態に基づくユーザー名の表示
                  birthdayAsync.when(
                    data: (value) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value.isEmpty ? '未設定' : value,
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
                      final result = await context.push<String>('/birthday');
                      if (result != null ) {
                        await ref.read(birthdayProvider.notifier).updateBirthday(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    'ホームゲレンデ:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // 非同期状態に基づくユーザー名の表示
                  gelandeAsync.when(
                    data: (value) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value.isEmpty ? '未設定' : value,
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
                      final result = await context.push<String>('/homegelande');
                      if (result != null ) {
                        await ref.read(gelandeProvider.notifier).updateGelande(result);
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