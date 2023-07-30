import 'package:flutter/material.dart';

class Contribute extends StatefulWidget {
  const Contribute({super.key});

  @override
  State<Contribute> createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contribute'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text('hellogit ')
        ],
      ),
    );
  }
}