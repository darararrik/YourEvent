import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/models/agent.dart';
import '/models/event.dart';


class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  // Слушатель изменений состояния аутентификации пользователя
  void onListenUser(void Function(User?)? doListen) {
    _auth.authStateChanges().listen(doListen);
  }

  // Логин пользователя
  Future<void> onLogin({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User logged in: ${credential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Login error: ${e.message}');
      }
    } catch (e) {
      print('An unknown error occurred: $e');
    }
  }

  // Регистрация пользователя
  Future<void> onRegister({
    required String nickname,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Обновление профиля пользователя
      await credential.user?.updateDisplayName(nickname);
      await credential.user?.updatePhotoURL('https://firebasestorage.googleapis.com/v0/b/yourevent123321.appspot.com/o/placeholders%2FUser%2FiRO4438p_ho.jpg?alt=media&token=d8b2be88-4be5-4cdf-b268-2a7d3532300b');

      // Добавление информации о пользователе в Firestore
      await _db.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'nickname': nickname,
        'email': email,
        'URL_Avatar': 'https://firebasestorage.googleapis.com/v0/b/yourevent123321.appspot.com/o/placeholders%2FUser%2FiRO4438p_ho.jpg?alt=media&token=d8b2be88-4be5-4cdf-b268-2a7d3532300b',
      });
      // Отправка подтверждения на email
      await credential.user?.sendEmailVerification();

      print('User registered: ${credential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Registration error: ${e.message}');
      }
    } catch (e) {
      print('An unknown error occurred: $e');
    }
  }

  // Логаут пользователя
  Future<void> logOut() async {
    await _auth.signOut();
  }

  // Отправка email для подтверждения
  Future<void> onVerifyEmail() async {
    try {
      await currentUser?.sendEmailVerification();
      print('Verification email sent to ${currentUser?.email}');
    } catch (e) {
      print('Failed to send verification email: $e');
    }
  }

  // Получение текущего пользователя
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Проверка, подтвержден ли email пользователя
  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }

  FirebaseFirestore getFirestoreInstance() {
    return _db;
  }
  // Добавление события
  Future<void> addEvent(Event event) {
    return _db.collection('events').add(event.toJson());
  }


  // Получение списка агентств
  Stream<List<Agency>> getAgencies() {
    return _db.collection('agencies').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Agency.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }


  // Получение списка событий
  Stream<List<Event>> getEvents() {
    return _db.collection('events').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}