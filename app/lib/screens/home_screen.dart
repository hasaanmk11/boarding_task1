import 'package:app/widgets/search_bar.dart';
import 'package:app/widgets/status_card.dart';
import 'package:app/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 230,
                color: Colors.black,
              ),

              TodoSearchBar(),
            ],
          ),
          SizedBox(height: 60),
          StatusCard(),
          SizedBox(height: 10),
          TodoCard(),
        ],
      ),
    );
  }
}
