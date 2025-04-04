//　go_routerの動作確認用
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Riverpodファイルのインポート
import 'package:sample_app/providers/csv_providers.dart';

class TestPage extends ConsumerStatefulWidget {
  const TestPage({super.key});

  @override
  ConsumerState<TestPage> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {

  @override
  Widget build(BuildContext context) {
    final listViewItems = ref.watch(makerCsvProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CSVからリストの表示'),
      ),
      body: listViewItems.when(
        data: (listViewItems){
          return ListView.builder(
        // indexはヘッダーを除外する
        itemCount: listViewItems.length -1 ,
        itemBuilder: (context, index) {
          final data = listViewItems[index + 1];
          return ListTile(
            title: Text(data[1].toString()), 
              );
            },
          );
        },
        error: (err, stack) => Center(child: Text('エラー: $err')),
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('読み込み中...'),
            ],
          ),
        ),
      )
    );
  }
}


class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPagePageState();
}

class _AboutPagePageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('タイトル'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('アバウトのページです')],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('タイトル'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('設定のページです')],
        ),
      ),
    );
  }
}
