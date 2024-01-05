import 'package:flutter/material.dart';

class ChipItem extends StatelessWidget {
  const ChipItem(
      {super.key,
        required this.onTap,
        required this.hasFocus,
        required this.current,
        required this.index,
        required this.title});

  final Function() onTap;
  final bool hasFocus;
  final int current;
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.all(10),
        width: 80,
        height: 45,
        decoration: BoxDecoration(
          color: hasFocus ? Colors.yellow : Colors.white,
          border: Border.all(
            color: current == index ? Colors.blue : Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: current == index ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}