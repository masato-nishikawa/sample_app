import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Riverpodファイルのインポート
import 'package:sample_app/providers/csv_providers.dart';

// TODO; マイページでギアを登録できる様にする
class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    final listViewItems = ref.watch(mainCsvProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('タイトル'),
      ),
      body: ListView.builder(
        // TODO: リストビューの構造の復習
        itemCount: listViewItems.length,
        itemBuilder: (context, index) {
          final data = listViewItems[index];
          return ListTile(
            title: Text(data[0].toString()), 
          );
        },
      ),
    );
  }


  // TODO: asyncの場合は下記になりそうだが要理解する
}

// body: mainCsvAsync.when(
//         data: (listViewItems) {
//           return ListView.builder(
//             itemCount: listViewItems.length,
//             itemBuilder: (context, index) {
//               final data = listViewItems[index];
//               return ListTile(
//                 title: Text(data[0].toString()),
//               );
//             },
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, stack) => Center(child: Text('エラー: $err')),
//       ),
//     );
//   }
// }