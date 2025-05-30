import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Riverpodファイルのインポート
import 'package:sample_app/providers/tab_providers.dart';
import 'package:sample_app/providers/icon_providers.dart';


class TabPage extends ConsumerStatefulWidget {
  const TabPage({super.key});

  @override
  ConsumerState<TabPage> createState() => _TabPageState();
}

class _TabPageState extends ConsumerState<TabPage> {
  @override
  Widget build(BuildContext context) {
    final tabs = ref.read(tabsProvider);
    final icons = ref.read(iconsProvider);


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
                        // 入れ替えて可読性を向上させる
                        final row = data[index];
                        final router = row[3];
                        final link = icons.firstWhere((item) => item[0] == row[4])[1];
                        // トリックのチェックボックス管理用
                        final trick = row[2];
                        final isChecked = ref.watch(checkboxProvider(trick));
                        return ListTile(
                          title: Row(
                            children: [
                              Text('$index. '),
                              Text(trick),
                              const Spacer(),
                              // チェックボックスは初期値をfalseにすることでタップされたら作成
                              Checkbox(
                                // ??はnullセーフで合体演算子
                                value: isChecked.value ?? false,
                                onChanged: (bool? value) {
                                // TODO: readなのにnotifierで値が変えられる？
                                  ref.read(checkboxProvider(trick).notifier).updateCheckbox(value ?? false);
                                },
                              ),
                              Image.asset(link, width: 30, height: 30),
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

