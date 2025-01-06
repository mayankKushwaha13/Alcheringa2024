import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  final String type;
  const HeaderTitle({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2,),
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          ClipRRect(
            child: Image.asset(
              "assets/images/1.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  type,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFF1E8),
                    fontSize: 22,
                    fontFamily: 'Game_Tape',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.15,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
