import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color.fromARGB(255, 46, 46, 46),
      ),
      width: MediaQuery.of(context).size.width - 20,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.circle_outlined, size: 26, color: Colors.white),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Do Math Homework",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "Due: 25 Feb 2025",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(180, 255, 255, 255),
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Color.fromARGB(110, 255, 255, 255),
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.delete_outline,
                  size: 22,
                  color: Color.fromARGB(110, 255, 255, 255),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
