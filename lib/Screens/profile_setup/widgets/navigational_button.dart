import 'package:flutter/material.dart';

class BackBtn extends StatefulWidget {
  const BackBtn({super.key});

  @override
  State<BackBtn> createState() => _BackBtnState();
}

class _BackBtnState extends State<BackBtn> {
  bool selected  = false;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        setState(() {
          selected=!selected;
        });
        Navigator.pop(context);
      },
      child: Stack(
        children: [
          Image.asset(
            selected
                ?"assets/images/profile_setup_button_bd.png"
                :"assets/images/profile_setup_button_b.png",
          ),
          Positioned.fill(
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "BACK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Alcherpixel',
                      color: selected?Color(0xFF1D2B53): Color(0xFF1D2B53),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}



class NextBtn extends StatefulWidget {
  final VoidCallback callBack;
  const NextBtn({super.key, required this.callBack});

  @override
  State<NextBtn> createState() => _NextBtnState();
}

class _NextBtnState extends State<NextBtn> {
  bool selected  = false;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        setState(() {
          selected=!selected;
        });
        widget.callBack();
      },
      child: Stack(
        children: [
          Image.asset(
            selected
                ?"assets/images/profile_setup_button_n.png"
                :"assets/images/profile_setup_button_n.png",
          ),
          Positioned.fill(
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    "Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Alcherpixel',
                      color: selected?Color(0xFFC2C3C7): Color(0xFF1D2B53),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
