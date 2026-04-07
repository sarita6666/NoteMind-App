import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();

  List<String> savedEmails = [];

  @override
  void initState() {
    super.initState();
    loadEmails();
  }

  void loadEmails() async {
    savedEmails = await auth.getSavedEmails();
    setState(() {});
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF7B2FF7),
            Color(0xFFF107A3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // 🔥 ICONO SUPERIOR
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.purple,
                  size: 30,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "NoteMine",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const Text(
                "Tu asistente inteligente de notas ADSO",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 25),

              // 🔥 CARD LOGIN
              Container(
                width: 340,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Ingresa tus credenciales para continuar",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // EMAIL
                    const Text("Email"),
                    const SizedBox(height: 5),

                    TextField(
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        hintText: "tu@email.com",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // EMAILS GUARDADOS
                    if (savedEmails.isNotEmpty)
                      Wrap(
                        children: savedEmails.map((email) {
                          return GestureDetector(
                            onTap: () {
                              emailCtrl.text = email;
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(email),
                            ),
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 10),

                    // PASSWORD
                    const Text("Contraseña"),
                    const SizedBox(height: 5),

                    TextField(
                      controller: passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "********",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔥 BOTÓN GRADIENTE
                    GestureDetector(
                      onTap: () async {
                        try {
                          final email = emailCtrl.text.trim();
                          final password = passCtrl.text.trim();

                          await auth.login(email, password);
                          await auth.saveEmail(email);

                          Navigator.pushReplacementNamed(context, "/home");

                        } on FirebaseAuthException catch (e) {
                          String mensaje = "Error";

                          if (e.code == 'user-not-found') {
                            mensaje = "Usuario no encontrado";
                          } else if (e.code == 'wrong-password') {
                            mensaje = "Contraseña incorrecta";
                          } else if (e.code == 'invalid-email') {
                            mensaje = "Correo inválido";
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(mensaje)),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF7B2FF7),
                              Color(0xFFF107A3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        child: const Text("¿No tienes una cuenta? Regístrate aquí"),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Demo: Crea una cuenta para probar NoteMine\nLos datos se guardan en tu navegador (localStorage)",
                        style: TextStyle(fontSize: 11),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}