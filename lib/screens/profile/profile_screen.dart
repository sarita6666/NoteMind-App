import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/custom_bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final user = FirebaseAuth.instance.currentUser;

  void editarPerfil(BuildContext context) {
    final nameCtrl = TextEditingController(
      text: user?.displayName ?? "",
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Perfil"),
          content: TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: "Nombre",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameCtrl.text.trim().isEmpty) return;

                await user?.updateDisplayName(nameCtrl.text.trim());
                await user?.reload();

                setState(() {});
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Perfil actualizado")),
                );
              },
              child: const Text("Guardar"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final updatedUser = FirebaseAuth.instance.currentUser;
    final name = updatedUser?.displayName ?? "Usuario";
    final email = updatedUser?.email ?? "correo@email.com";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: Column(
          children: [

            // 🔥 HEADER
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF7B2FF7),
                    Color(0xFFF107A3),
                  ],
                ),
              ),
              child: Row(
                children: const [
                  Icon(Icons.auto_awesome, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "NoteMine",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Row(
                      children: [
                        Icon(Icons.person, color: Colors.purple),
                        SizedBox(width: 10),
                        Text(
                          "Mi Perfil",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Text(
                      "Administra tu información personal",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    // 🔥 CARD PERFIL
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10)
                        ],
                      ),
                      child: Column(
                        children: [

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Información",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Tu perfil de NoteMine",
                                style: TextStyle(color: Colors.grey)),
                          ),

                          const SizedBox(height: 20),

                        
                          Stack(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF7B2FF7),
                                      Color(0xFFF107A3),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    name[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Próximamente: subir foto"),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 18,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: 10),

                          Text(
                            name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          Text(
                            email,
                            style: const TextStyle(color: Colors.grey),
                          ),

                          const SizedBox(height: 15),

                          // 🔥 BOTÓN EDITAR
                          OutlinedButton(
                            onPressed: () => editarPerfil(context),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 45),
                            ),
                            child: const Text("Editar Perfil"),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10)
                        ],
                      ),
                      child: Column(
                        children: [

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Mis Notas",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),

                          const SizedBox(height: 30),

                          Icon(Icons.description_outlined,
                              size: 60, color: Colors.grey.shade400),

                          const SizedBox(height: 10),

                          const Text("No tienes notas aún",
                              style: TextStyle(fontWeight: FontWeight.bold)),

                          const SizedBox(height: 5),

                          const Text("Comienza creando tu primera nota",
                              style: TextStyle(color: Colors.grey)),

                          const SizedBox(height: 15),

                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF7B2FF7),
                                  Color(0xFFF107A3),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/notes');
                              },
                              child: const Text(
                                "Crear Nota",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
    );
  }
}