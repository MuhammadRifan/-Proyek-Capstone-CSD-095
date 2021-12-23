import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWeek extends StatefulWidget {
  ButtonWeek({
    Key? key,
    required this.week,
    required this.onTap,
    this.isClicked = false,
  }) : super(key: key);

  final String week;
  final GestureTapCallback onTap;
  bool isClicked;

  @override
  State<ButtonWeek> createState() => _ButtonWeekState();
}

class _ButtonWeekState extends State<ButtonWeek> {
  // bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapUp: (details) {
        setState(() {
          widget.isClicked = !widget.isClicked;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: (widget.isClicked) ? Colors.grey.shade400 : null,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade400,
          ),
        ),
        child: Text(
          widget.week,
          style: TextStyle(
            color: (widget.isClicked) ? Colors.black87 : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
