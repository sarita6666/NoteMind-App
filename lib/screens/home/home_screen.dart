import 'package:flutter/material.dart';
import '../../widgets/header_home.dart';
import '../../widgets/grid_options.dart';
import '../../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: Column(
          children: [

            
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
              child: const HeaderHome(),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Mis Notas",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "0 notas",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        
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
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/notes');
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text(
                              "Nueva Nota",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔥 FILTRO
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
                      child: Row(
                        children: [
                          const Icon(Icons.filter_list, color: Colors.purple),
                          const SizedBox(width: 10),
                          const Text("Filtrar por categoría:"),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            value: "Todas",
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(
                                value: "Todas",
                                child: Text("Todas las categorías"),
                              ),
                            ],
                            onChanged: (value) {},
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔥 EMPTY STATE (igual a la imagen)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.purple.shade100,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        children: [

                          Icon(
                            Icons.menu_book_outlined,
                            size: 60,
                            color: Colors.purple.shade200,
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "No hay notas aún",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Crea tu primera nota para comenzar",
                            style: TextStyle(color: Colors.grey),
                          ),

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
                                "Crear Primera Nota",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // 🔥 ACCESOS (tu GridOptions pero abajo)
                    const Text(
                      "Accesos rápidos",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const SizedBox(
                      height: 200,
                      child: GridOptions(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
    );
  }
}