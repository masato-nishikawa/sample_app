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
    final myBoardAsync = ref.watch(myBoardProvider);


// TODO: ボード追加についてはリストで返す
    return Scaffold(
      appBar: AppBar(
          title: const Text('マイページ'),
          actions: [
            // ユーザー情報の一括リセット
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'リセット',
              onPressed: () {
                ref.read(userProvider.notifier).resetUsername();
                ref.read(prefectureProvider.notifier).resetPrefecture();
                ref.read(genderProvider.notifier).resetGender();
                ref.read(birthdayProvider.notifier).resetBirthday();
                ref.read(gelandeProvider.notifier).resetGelande();
                ref.read(myBoardProvider.notifier).resetMyBoard();
              },
            ),
          ],
        ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 名前表示と編集ボタンのRow
            Padding(
              // 上下に対象の余白を挿入している
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text('名前',
                    // フォントサイズと太線の指定
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      // 名前編集画面へ遷移し、結果を受け取る
                      final result = await context.push<String>('/mypage/addname');
                      // 受け取った結果に対してnotifierでアップデートをかける
                      if (result != null ) {
                        await ref.read(userProvider.notifier).updateUsername(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            // 非同期状態に基づくユーザー名の表示
            usernameAsync.when(
              // ロード完了後に表示させるデータ
              data: (value) => Align(
                alignment: Alignment.center,
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
            // 都道府県の情報追加
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    '都道府県',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      // 名前編集画面へ遷移し、結果を受け取る
                      final result = await context.push<String>('/mypage/prefecture');
                      if (result != null ) {
                        await ref.read(prefectureProvider.notifier).updatePrefecture(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            // 非同期状態に基づく都道府県の表示
            prefectureAsync.when(
              data: (value) => Align(
                alignment: Alignment.center,
                child: Text(
                  value.isEmpty ? '未設定' : value,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('エラーが発生しました: $err'),
            ),
            // 性別についての情報
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    '性別',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      // 名前編集画面へ遷移し、結果を受け取る
                      final result = await context.push<String>('/mypage/gender');
                      if (result != null ) {
                        await ref.read(genderProvider.notifier).updateGender(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            // 非同期状態に基づく性別の表示
            genderAsync.when(
              data: (value) => Align(
                alignment: Alignment.center,
                child: Text(
                  value.isEmpty ? '未設定' : value,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('エラーが発生しました: $err'),
            ),
            // 誕生日についての情報
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    '誕生日',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      // 名前編集画面へ遷移し、結果を受け取る
                      final result = await context.push<String>('/mypage/birthday');
                      if (result != null ) {
                        await ref.read(birthdayProvider.notifier).updateBirthday(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            // 非同期状態に基づく誕生日の表示
            birthdayAsync.when(
              data: (value) => Align(
                alignment: Alignment.center,
                child: Text(
                  value.isEmpty ? '未設定' : value,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('エラーが発生しました: $err'),
            ),
            // ホームゲレンデについての情報
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    'ホームゲレンデ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      // 名前編集画面へ遷移し、結果を受け取る
                      final result = await context.push<String>('/mypage/homegelande');
                      if (result != null ) {
                        await ref.read(gelandeProvider.notifier).updateGelande(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            // 非同期状態に基づくホームゲレンデの表示
            gelandeAsync.when(
              data: (value) => Align(
                alignment: Alignment.center,
                child: Text(
                  value.isEmpty ? '未設定' : value,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('エラーが発生しました: $err'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    'スノーボード',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      // 名前編集画面へ遷移し、結果を受け取る
                      final result = await context.push<List<List<String>>>('/mypage/my_board');
                      if (result != null ) {
                        await ref.read(myBoardProvider.notifier).updateMyBoard(result);
                      }
                    },
                  ),
                ],
              ),
            ),
            // 非同期状態に基づくホームゲレンデの表示
            myBoardAsync.when(
              data: (value) => value.isEmpty
                  ? const Center(child: Text('未設定', style: TextStyle(fontSize: 18.0)))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        final board = value[index]; // 例: ['BURTON', 'CUSTOM', '158']
                        final displayText = board.join(' '); // "BURTON CUSTOM 158"
                        return ListTile(
                          leading: Text((index + 1).toString()),
                          title: Text(displayText),
                        );
                      },
                    ),
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('エラーが発生しました: $err'),
            )
          ],
        ),
      ),
    );
  }
}