import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//　router
import 'package:sample_app/router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.push('/mypage');
              },
              child: Text('マイページへ'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/test');
              },
              child: Text('テストページへ'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/about');
              },
              child: Text('アバウトページへ'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/settings');
              },
              child: Text('設定ページへ'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     ref
      //   }

      // ),
    );
  }
}
