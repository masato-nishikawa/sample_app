import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Statefulである必要がないのでStatelessにする

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.push('/tab');
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 24),
                minimumSize: const Size(300, 100),
              ),
              child: Text('タブ画面へ'),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                context.push('/mypage');
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 24),
                minimumSize: const Size(300, 100),
              ),
              child: Text('マイページへ'),
            ),
            const SizedBox(height: 100),
            // 個別で確認したい画面がある場合に使う
            ElevatedButton(
              onPressed: () {
                context.push('/about');
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 24),
                minimumSize: const Size(300, 100),
                backgroundColor: Colors.lightBlue,
              ),
              child: Text('動作テストページへ'),
            ),
            const Text('※Youtube再生のテスト中'),
            const Text('（実機での動作は確認）'),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
