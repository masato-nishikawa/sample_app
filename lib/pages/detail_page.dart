import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';
// Riverpodファイルのインポート
import 'package:sample_app/providers/detail_providers.dart';




class DetailPage extends ConsumerStatefulWidget {
  final String trickName;
  const DetailPage({super.key, required this.trickName});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}


class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trickName),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // pushでなくgoにする事で一気にスタックを解除できる
              context.go('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('・How to 動画',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
            ),
            YouTubePlayerSection(trickName: widget.trickName),
            const Text('トリックの手順',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
            ),
            TrickFlowSection(trickName: widget.trickName),
            const Text('セッティング',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
            ),
            SettingsSection(trickName: widget.trickName),
            const Text('ギア詳細',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
            ),
            GearsSection(trickName: widget.trickName),
            const Text('要素トリック',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
            ),
            StepdownsSection(trickName: widget.trickName),
            const Text('ステップアップ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
            ),
            StepupsSection(trickName: widget.trickName),
          ],
        ),
      ),
    );
  }
}

class YouTubePlayerSection extends ConsumerWidget {
  final String trickName;
  const YouTubePlayerSection({super.key, required this.trickName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final youtube = ref.watch(youtubeLinkProvider(trickName));

    return youtube.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, child) => Text('動画取得エラー: $error'),
      data: (videoId) {
        final controller = YoutubePlayerController.fromVideoId(
          videoId: videoId,
          params: const YoutubePlayerParams(
            mute: false,
            showControls: true,
            showFullscreenButton: true,
          ),
        );
        return YoutubePlayer(controller: controller);
      },
    );
  }
}

class TrickFlowSection extends ConsumerWidget {
  final String trickName;
  const TrickFlowSection({super.key, required this.trickName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trickFlow = ref.watch(trickFlowProvider(trickName));

    return trickFlow.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, child) => Text('取得エラー: $error'),
      data: (data) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Text('${index + 1}.'),
                      Text(data[index].toString()),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class SettingsSection extends ConsumerWidget {
  final String trickName;
  const SettingsSection({super.key, required this.trickName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider(trickName));

    return settings.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, child) => Text('取得エラー: $error'),
      data: (data) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Text(data[index][0].toString()),
                      Text(' : '),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(data[index][1].toString())),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class GearsSection extends ConsumerWidget {
  final String trickName;
  const GearsSection({super.key, required this.trickName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gears = ref.watch(gearsProvider(trickName));

    return gears.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, child) => Text('取得エラー: $error'),
      data: (data) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Text(data[index][0].toString()),
                      Text(' : '),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async {
                              await _launchURL(data[index][2].toString());
                            },
                            child: Text(
                              data[index][1].toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Future<void> _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'このURLを開けません: $url';
  }
}

class StepdownsSection extends ConsumerWidget {
  final String trickName;
  const StepdownsSection({super.key, required this.trickName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepdown = ref.watch(stepdownsProvider(trickName));

    return stepdown.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, child) => Text('取得エラー: $error'),
      data: (data) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Text('${index + 1}.'),
                      Text(data[index][0].toString()),
                    ],
                  ),
                ],
              ),
              onTap: () {
                context.push('/tab/${data[index][1]}');
              },
            );
          },
        );
      },
    );
  }
}

class StepupsSection extends ConsumerWidget {
  final String trickName;
  const StepupsSection({super.key, required this.trickName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepup = ref.watch(stepupsProvider(trickName));

    return stepup.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, child) => Text('取得エラー: $error'),
      data: (data) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Text('${index + 1}.'),
                      Text(data[index][0].toString()),
                    ],
                  ),
                ],
              ),
              onTap: () {
                context.push('/tab/${data[index][1]}');
              },
            );
          },
        );
      },
    );
  }
}