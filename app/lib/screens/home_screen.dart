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

              Positioned(
                bottom: -30,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "🚀 Search...",
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 46, 46, 46),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text("Add"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E6F9F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Pending",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 83, 158, 220),
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Complited",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 18, 100, 167),
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 2),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey,
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
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
                    Icon(Icons.circle_outlined, size: 26, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      "Do Math Homework",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
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
          ),
        ],
      ),
    );
  }
}
