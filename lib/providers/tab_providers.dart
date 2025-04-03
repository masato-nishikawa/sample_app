import 'package:flutter_riverpod/flutter_riverpod.dart';


final tabsProvider = Provider<List<List<String>>>((ref) {
  return [
    ['弾き系', 'assets/icons/tab1.png'],
    ['バター系', 'assets/icons/tab2.png'],
    ['カービング', 'assets/icons/tab3.png'],
    ['ハーフパイプ', 'assets/icons/tab4.png'],
    ['キッカー', 'assets/icons/tab5.png'],
    ['ジブ', 'assets/icons/tab6.png'],
    ['バックカントリー', 'assets/icons/tab7.png'],
    ['メンテナンス', 'assets/icons/tab8.png'],
    ['マイページ', 'assets/icons/tab9.png'],
  ];
});
