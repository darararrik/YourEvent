import 'package:YourEvent/design/colors.dart';
import 'package:flutter/material.dart';


class CustomIconButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122,
      height: 141,
      decoration: BoxDecoration(
        border: Border.all(color: outline,width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0), // Уменьшение внутреннего отступа
          backgroundColor: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              height: 70, // Уменьшение высоты изображения
              width: 70, // Уменьшение ширины изображения
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center, // Выравнивание текста по центру
              style: const TextStyle(
                fontSize: 12, // Уменьшение размера текста
                color: secondaryGray,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
