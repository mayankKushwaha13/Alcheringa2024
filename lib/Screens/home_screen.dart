import 'package:alcheringa/Model/view_model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/eventdetail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<EventDetail> list = Provider.of<ViewModelMain>(context).allEvents;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alcheringa",
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Vacation Heavy'
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.account_circle_outlined),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ViewModelMain().getValue('userName').toString())
        ],
      ),
    );
  }
}
