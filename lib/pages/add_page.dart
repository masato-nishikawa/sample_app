import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/providers/csv_providers.dart';

// ニックネームの入力画面
class AddPageName extends StatefulWidget {
  const AddPageName({super.key});

  @override
  State<AddPageName> createState() => _AddPageNameState();
}

class _AddPageNameState extends State<AddPageName> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // メモリ解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('名前入力画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '名前を入力してください。',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('保存'),
              onPressed: () {
                context.pop(_controller.text); // 戻り値を渡す
              },
            ),
          ],
        ),
      ),
    );
  }
}


// 都道府県入力画面
class AddPagePrefecture extends StatefulWidget {
  const AddPagePrefecture({super.key});

  @override
  State<AddPagePrefecture> createState() => _AddPagePrefectureState();
}

class _AddPagePrefectureState extends State<AddPagePrefecture> {
  Prefectures? _selectedPrefecture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('都道府県入力画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ドロップダウンの作成
            DropdownButtonFormField<Prefectures>(
              value: _selectedPrefecture,
              // 都道府県の値を日本語の方で表示する
              items: Prefectures.values.map((Prefectures prefecture) {
                return DropdownMenuItem<Prefectures>(
                  value: prefecture,
                  child: Text(prefecture.text),
                );
              }).toList(),
              // 画面を再描画して選んだ都道府県の確認
              onChanged: (Prefectures? newValue) {
                setState(() {
                  _selectedPrefecture = newValue;
                });
              },
              decoration: const InputDecoration(
                hintText: '都道府県を選択',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
                child: const Text('保存'),
                onPressed: () {
                  context.pop(_selectedPrefecture!.text);
                }),
          ],
        ),
      ),
    );
  }
}
//都道府県のプルダウン用のリスト
enum Prefectures {
  hokkaido(text: '北海道'),
  aomori(text: '青森県'),
  iwate(text: '岩手県'),
  miyagi(text: '宮城県'),
  akita(text: '秋田県'),
  yamagata(text: '山形県'),
  fukushima(text: '福島県'),
  ibaraki(text: '茨城県'),
  tochigi(text: '栃木県'),
  gunma(text: '群馬県'),
  saitama(text: '埼玉県'),
  chiba(text: '千葉県'),
  tokyo(text: '東京都'),
  kanagawa(text: '神奈川県'),
  niigata(text: '新潟県'),
  toyama(text: '富山県'),
  ishikawa(text: '石川県'),
  fukui(text: '福井県'),
  yamanashi(text: '山梨県'),
  nagano(text: '長野県'),
  gifu(text: '岐阜県'),
  shizuoka(text: '静岡県'),
  aichi(text: '愛知県'),
  mie(text: '三重県'),
  shiga(text: '滋賀県'),
  kyoto(text: '京都府'),
  osaka(text: '大阪府'),
  hyogo(text: '兵庫県'),
  nara(text: '奈良県'),
  wakayama(text: '和歌山県'),
  tottori(text: '鳥取県'),
  shimane(text: '島根県'),
  okayama(text: '岡山県'),
  hiroshima(text: '広島県'),
  yamaguchi(text: '山口県'),
  tokushima(text: '徳島県'),
  kagawa(text: '香川県'),
  ehime(text: '愛媛県'),
  kochi(text: '高知県'),
  fukuoka(text: '福岡県'),
  saga(text: '佐賀県'),
  nagasaki(text: '長崎県'),
  kumamoto(text: '熊本県'),
  oita(text: '大分県'),
  miyazaki(text: '宮崎県'),
  kagoshima(text: '鹿児島県'),
  okinawa(text: '沖縄県');

  const Prefectures({required this.text});
  final String text;
}


// 性別の入力画面
class AddPageGender extends StatefulWidget {
  const AddPageGender ({super.key});

  @override
  State<AddPageGender> createState() => _AddPageGenderState();
}

class _AddPageGenderState extends State<AddPageGender> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('性別入力画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '性別を選択してください:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            RadioListTile<String>(
              title: const Text('男性'),
              value: '男性',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('女性'),
              value: '女性',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('その他'),
              value: 'その他',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
                child: const Text('保存'),
                onPressed: () {
                  context.pop(_selectedGender!);
                }),
          ],
        ),
      ),
    );
  }
}


// 誕生日の入力画面
class AddPageBirthday extends StatefulWidget {
  const AddPageBirthday({super.key});

  @override
  State<AddPageBirthday> createState() => _AddPageBirthday();
}

class _AddPageBirthday extends State<AddPageBirthday> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('誕生日を選択してください'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              FormBuilderDateTimePicker(
                name: 'birthday',
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: '誕生日',
                ),
                initialDate: DateTime(1997, 8, 17),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                format: DateFormat('yyyy/MM/dd'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    DateTime? selectedDate =
                        _formKey.currentState!.value['birthday'];
                    if (selectedDate != null) {
                      String formattedDate =
                          "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                            context.pop(formattedDate); // 日付を返す
                    }
                  }
                },
                child: Text('保存'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ホームゲレンデの入力画面
class AddPageGelande extends StatefulWidget {
  const AddPageGelande({super.key});

  @override
  State<AddPageGelande> createState() => _AddPageGelandeState();
}

class _AddPageGelandeState extends State<AddPageGelande> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // メモリ解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホームゲレンデの入力画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '名前を入力してください。',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('保存'),
              onPressed: () {
                context.pop(_controller.text); // 戻り値を渡す
              },
            ),
          ],
        ),
      ),
    );
  }
}


// スノーボード入力画面
class AddPageMyBoard extends ConsumerStatefulWidget {
  const AddPageMyBoard({super.key});

  @override
  ConsumerState<AddPageMyBoard> createState() => _AddPageMyBoardState();
}

class _AddPageMyBoardState extends ConsumerState<AddPageMyBoard> {
  String? selectedMaker; 
  final TextEditingController modelName = TextEditingController();
  int? selectedSize;
  List<List<String>> boardList = [];
  
  // TOOD: 必要性の理解
  @override
  void dispose() {
    modelName.dispose(); // メモリ解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final makerData = ref.watch(makerCsvProvider);
    final sizeList = List.generate(190 - 120 + 1, (i) => 120 + i);

    return Scaffold(
      appBar: AppBar(
        title: const Text('マイボードの入力画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: makerData.when(
          data: (data) {
            final boardList = data['board']!
                .map((e) => e.toString())
                .toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'ボードメーカーを選択',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedMaker,
                  items: boardList.map((maker) {
                    return DropdownMenuItem<String>(
                      value: maker,
                      child: Text(maker),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMaker = value;
                    });
                  },
                ),

                const SizedBox(height: 16.0),

                TextField(
                  controller: modelName,
                  decoration: const InputDecoration(
                    hintText: 'モデル名を入力してくだい。',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16.0),

                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'サイズを選択',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedSize,
                  items: sizeList.map((size) {
                    return DropdownMenuItem<int>(
                      value: size,
                      child: Text(size.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: (
                    // 3項目が未入力でないことの確認
                    selectedMaker != null &&
                    selectedSize != null &&
                    modelName.text.isNotEmpty)
                      ? () {
                        // リストのリストでString型にして返す
                        final result = [[
                          selectedMaker!, modelName.text, selectedSize.toString()
                        ]];
                          context.pop(result);
                        }
                      : null,
                  child: const Text('保存'),
                ),
                const Text('*3つ全ての項目を入力してください。'),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('エラー: $err')),
        ),
      ),
    );
  }
}