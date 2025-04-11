//　go_routerの動作確認用
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// Riverpodファイルのインポート
import 'package:sample_app/providers/csv_providers.dart';

// TODO: Youtubeのリンクが表示されるようにする(実機動作確認済み)

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
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: YoutubePlayer(
            controller: YoutubePlayerController.fromVideoId(
              videoId: 'jNQXAC9IVRw',
              params: const YoutubePlayerParams(
                mute: false,
                showControls: true,
                showFullscreenButton: true,
                playsInline: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// アプリ上のルーティングから削除中
class TestPage extends ConsumerStatefulWidget {
  const TestPage({super.key});

  @override
  ConsumerState<TestPage> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {

  @override
  Widget build(BuildContext context) {
    // 非同期の際には「watch」を使わなくてはならない
    final listViewItems = ref.watch(makerCsvProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CSVからリストの表示'),
      ),
      body: listViewItems.when(
        data: (listViewItems){
          final boardList = listViewItems['board']!;
          return ListView.builder(
        // indexはヘッダーを除外する
        itemCount: boardList.length ,
        itemBuilder: (context, index) {
          final data = boardList[index];
          return ListTile(
            title: Text(data.toString()), 
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
              Text('2秒の待機時間があります。'),
            ],
          ),
        ),
      )
    );
  }
}

// 何にも使用していない
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