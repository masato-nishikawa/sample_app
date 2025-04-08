import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// Riverpodファイルのインポート
import 'package:sample_app/providers/detail_providers.dart';

// TODO: レイアウトの整理


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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('・How to 動画'),
            const SizedBox(height: 12),
            YouTubePlayerSection(trickName: widget.trickName),
            const SizedBox(height: 12),
            Text('トリックの手順'),
            TrickFlowSection(trickName: widget.trickName),
            Text('セッティング'),
            settingsSection(trickName: widget.trickName),
            Text('ギア詳細'),
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
          shrinkWrap: true,
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

class settingsSection extends ConsumerWidget {
  final String trickName;
  const settingsSection({super.key, required this.trickName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider(trickName));

    return settings.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, child) => Text('取得エラー: $error'),
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Text(data[index][0].toString()),
                      Text(' : '),
                      Text(data[index][1].toString()),
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