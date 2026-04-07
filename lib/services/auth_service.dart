import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<User?> register(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<void> saveEmail(String email) async {
  final prefs = await SharedPreferences.getInstance();

  List<String> emails = prefs.getStringList("emails") ?? [];

  if (!emails.contains(email)) {
    emails.add(email);
    await prefs.setStringList("emails", emails);
  }
}

  Future<List<String>> getSavedEmails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("emails") ?? [];
  }
  User? get currentUser => _auth.currentUser;

  Future<void> logout() async {
    await _auth.signOut();
  }

}