import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Image.asset('assets/images/logo.png', width: 54, height: 54),
          ),
          // Icon(Icons.music_note, size: 60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MyRoadie",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Gerencie seus eventos",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              print('ABRIR POPUP!!!!');
            },
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFf59e0b),
              foregroundColor: Colors.white,
            ),
            child: Row(
              children: [Icon(Icons.add), SizedBox(width: 4), Text("Novo")],
            ),
          ),
        ],
      ),
    );
  }
}
