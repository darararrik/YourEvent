import 'package:flutter/material.dart';
import '../firebase_service.dart';
import '/design/colors.dart';
import '/widgets/customButton_form.dart';
import '/widgets/inputButton.dart';

import 'homePage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseService firebaseService = FirebaseService();

  void _register() async {
    final nickname = nicknameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (nickname.isEmpty || email.isEmpty || password.isEmpty) {
      // Показать сообщение об ошибке
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Все поля должны быть заполнены')),
      );
      return;
    }
    try {
      await firebaseService.onRegister(
        nickname: nickname,
        email: email,
        password: password,
      );

      // Перейти на главный экран после успешной регистрации
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
      );
    } catch (e) {
      // Показать сообщение об ошибке
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 36),
              const Text(
                'Регистрация',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 100),
              InputButton(
                text: "НИКНЕЙМ",
                controller: nicknameController, // Add your own controller

              ),
              const SizedBox(height: 16),
              InputButton(
                text: "E-MAIL",
                controller: emailController, // Add your own controller

              ),
              const SizedBox(height: 16),
              InputButton(
                text: "ПАРОЛЬ",
                controller: passwordController, // Add your own controller
                obscureText: true,
              ),
              const SizedBox(height: 24),
              CustomButton(text: "Зарегистрироваться",
                  backgroundColor: primaryContainer,
                  textColor: Colors.white,
                  onPressed:() {
                    _register();
                  } )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // Вызываем метод dispose() для контроллеров
    emailController.dispose();
    passwordController.dispose();
    nicknameController.dispose();
    super.dispose();
  }
}



