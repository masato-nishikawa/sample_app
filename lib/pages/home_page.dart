import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                context.push('/tab');
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 24),
                minimumSize: const Size(300, 100),
              ),
              
              child: Text('タブ画面へ'),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                context.push('/mypage');
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 24),
                minimumSize: const Size(300, 100),
              ),
              child: Text('マイページへ'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
