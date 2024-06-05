import 'package:YourEvent/design/colors.dart';
import 'package:flutter/material.dart';
class InputButton extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool obscureText;
  const InputButton({
    super.key,
    required this.controller,
    required this.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
        style: const TextStyle(
          fontSize: 14,
          color: textFieldColor,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: textFieldBackgroundColor, // Background color of the container
            border: Border.all(
              color: textFieldOutlineColor, // Цвет границы
              width: 0.5, // Толщина границы
            ),
            ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
