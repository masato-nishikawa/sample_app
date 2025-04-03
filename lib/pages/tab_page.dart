import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Riverpodファイルのインポート
import 'package:sample_app/providers/tab_providers.dart';

class TabPage extends ConsumerStatefulWidget {
  const TabPage({super.key});

  @override
  ConsumerState<TabPage> createState() => _TabPageState();
}

class _TabPageState extends ConsumerState<TabPage> {
  @override
  Widget build(BuildContext context) {
    final tabs = ref.watch(tabsProvider);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('タイトル'),
        ),
        //　Materialで囲んでなくても大丈夫
        bottomNavigationBar: TabBar(
          //　.mapで開いてタブの中にぶち込んでいる
          tabs: tabs.map((tab) {
            return Tab(
              // AIで作ったアイコンの画像を入れる
              icon: Image.asset(tab[1], width: 50, height: 50),
              // スノーボードのジャンル名
              text: tab[0],
            );
          }).toList(),
          //　タブの数が多いためスクロールをする
          isScrollable: true,
        ),
        // TODO: bodyではリストビューをしていく
        body: TabBarView(
          children: tabs.map((tab) {
            return Center(child: Text('${tab[0]} ページ'));
          }).toList(),
        ),
      ),
    );
  }
}
