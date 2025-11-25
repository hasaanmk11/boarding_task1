import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
