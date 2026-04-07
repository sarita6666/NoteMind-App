import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();

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

              // 🔥 CARD REGISTER
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
                      "Crear Cuenta",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Regístrate para comenzar a usar NoteMine",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // NOMBRE
                    const Text("Nombre Completo"),
                    const SizedBox(height: 5),

                    TextField(
                      controller: nameCtrl,
                      decoration: InputDecoration(
                        hintText: "Juan Pérez",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

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

                    // PASSWORD
                    const Text("Contraseña"),
                    const SizedBox(height: 5),

                    TextField(
                      controller: passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Mínimo 6 caracteres",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // CONFIRM PASSWORD
                    const Text("Confirmar Contraseña"),
                    const SizedBox(height: 5),

                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Repite tu contraseña",
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
                          final user = await auth.register(
                            emailCtrl.text.trim(),
                            passCtrl.text.trim(),
                          );

                          await user?.updateDisplayName(
                            nameCtrl.text.trim(),
                          );

                          Navigator.pushReplacementNamed(context, "/home");

                        } on FirebaseAuthException catch (e) {

                          String mensaje = "Error";

                          if (e.code == 'email-already-in-use') {
                            mensaje = "El correo ya está en uso";
                          } else if (e.code == 'weak-password') {
                            mensaje = "Contraseña muy débil";
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
                            "Crear Cuenta",
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
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "¿Ya tienes una cuenta? Inicia sesión aquí",
                        ),
                      ),
                    ),
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