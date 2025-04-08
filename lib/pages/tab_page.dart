import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Riverpodファイルのインポート
import 'package:sample_app/providers/tab_providers.dart';

// TODO: タブの幅を統一する

class TabPage extends ConsumerStatefulWidget {
  const TabPage({super.key});

  @override
  ConsumerState<TabPage> createState() => _TabPageState();
}

class _TabPageState extends ConsumerState<TabPage> {
  @override
  Widget build(BuildContext context) {
    final tabs = ref.read(tabsProvider);


    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('カテゴリ別の一覧'),
          //　Materialで囲んでなくても大丈夫
          bottom: TabBar(
            //　.mapで開いてタブの中にぶち込んでいる
            tabs: tabs.map((tab) {
              return Tab(
                // AIで作ったアイコンの画像を入れる
                icon: Image.asset(tab[1], width: 80, height: 50),
                // スノーボードのジャンル名
                text: tab[0],
              );
            }).toList(),
            //　タブの数が多いためスクロールをする
            isScrollable: true,
          ),
        ),
        // TODO: bodyではリストビューで画面遷移を追加していく
        body: TabBarView(
          // tabsからリストを展開して1つ1つをtabとして動作
          children: tabs.map((tab) {
            // カテゴリ名を取り出す
            final category = tab[0];
            return Consumer(
              // _は分かりにくのでchildにする
              builder: (context, ref, child) {
                final tricsData = ref.watch(categoryProvider(category)); // セミコロン追加
                return tricsData.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.length, // 誤字修正
                      itemBuilder: (context, index) {
                        final row = data[index];
                        final router = row[3];
                        return ListTile(
                          title: Row(
                            children: [
                              Text('$index. '),
                              Text(row[2]),
                            ],
                          ),
                          onTap: () {
                            context.push('/tab/$router');
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}