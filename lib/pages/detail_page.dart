import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String trickName ;
  
  const DetailPage({super.key, required this.trickName});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('タイトル'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(widget.trickName)],
        ),
      ),
    );
  }
}
