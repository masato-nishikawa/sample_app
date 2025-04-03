import 'package:flutter_riverpod/flutter_riverpod.dart';


final iconsProvider = Provider<List<List<dynamic>>>((ref) {
  return [
    [1, 'assets/icons/rank1.png'],
    [2, 'assets/icons/rank2.png'],
    [3, 'assets/icons/rank3.png'],
    [4, 'assets/icons/rank4.png'],
    [5, 'assets/icons/rank5.png'],
    [6, 'assets/icons/rank6.png'],
    [7, 'assets/icons/rank7.png'],
    [8, 'assets/icons/rank8.png'],
    [9, 'assets/icons/rank9.png'],
    [10, 'assets/icons/rank10.png'],
  ];
});
