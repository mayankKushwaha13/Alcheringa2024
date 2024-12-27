import 'package:flutter/material.dart';

class IntrestButton extends StatefulWidget {
  final String intrest;
  final Function(String, bool) onSelected; // Callback to notify parent

  const IntrestButton({
    super.key,
    required this.intrest,
    required this.onSelected,
  });

  @override
  State<IntrestButton> createState() => _IntrestButtonState();
}

class _IntrestButtonState extends State<IntrestButton> {
  bool selected = false;

  void toggleSelection() {
    setState(() {
      selected = !selected;
      widget.onSelected(widget.intrest, selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelection,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              selected
                  ? "assets/images/profile_setup_interest_bg_sel.png"
                  : "assets/images/profile_setup_interest_bg_unsel.png",
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                widget.intrest,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Alcherpixel',
                  color: selected ? Color(0xFF83769C) : Color(0xFF1D2B53),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
