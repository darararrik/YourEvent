import 'package:YourEvent/screens/loginPage.dart';
import 'package:flutter/material.dart';
import '/design/colors.dart';
import '/screens/registrationPage.dart';
import '../design/images.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 36), // Отступ от верхнего края
              logo,
              const SizedBox(height: 80),
              const Text(
                'Все для праздника\nв одном месте',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat', // Установка семейства шрифтов
                ),
              ),
              const SizedBox(height: 12),
              firstPhoto,
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: primaryContainer,
                      width: 2,
                    ),
                  ),
                  fixedSize: const Size(300, 44), // Ширина и высота кнопки
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()));
                },
                child: const Text(
                  'Создать аккаунт',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: primaryContainer,
                      width: 2,
                    ),
                  ),
                  fixedSize: const Size(300, 44), // Ширина и высота кнопки
                ),
                onPressed: ()
                {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
                },

                child: const Text(
                  'Войти',
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryContainer,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
