import 'package:flutter/material.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Logs', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                const Text('Registro de actividades del sistema'),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 196, 119, 148),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Todas', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Usuario', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Ventas', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Inventario', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ),

               Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 310,
                        child: SearchBar(
                          hintText: ('Buscar por usuario o acción '),
                          leading: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_alt_rounded),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Color.fromARGB(255, 245, 120, 162),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Carlos Pérez', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                const Text('Registró una venta', style: TextStyle(color: Colors.black, fontSize: 12),),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 255, 205, 220),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text('Ventas', style: TextStyle(color: Colors.black, fontSize: 11)),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('29 sep 2025 · 10:32 a.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Color.fromARGB(255, 245, 120, 162),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Leyani Chávez', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                const Text('Actualizó un producto', style: TextStyle(color: Colors.black, fontSize: 12),),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 255, 205, 220),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text('Inventario', style: TextStyle(color: Colors.black, fontSize: 11)),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('29 sep 2025 · 10:15 a.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Color.fromARGB(255, 245, 120, 162),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Ana Torres', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                const Text('Ingresó al sistema', style: TextStyle(color: Colors.black, fontSize: 12),),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 255, 205, 220),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text('Usuarios', style: TextStyle(color: Colors.black, fontSize: 11)),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('29 sep 2025 · 09:48 a.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Color.fromARGB(255, 245, 120, 162),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Miguel Rodríguez', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                const Text('Eliminó un cliente', style: TextStyle(color: Colors.black, fontSize: 12),),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 255, 205, 220),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text('Clientes', style: TextStyle(color: Colors.black, fontSize: 11)),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('29 sep 2025 · 09:20 a.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Color.fromARGB(255, 255, 205, 220),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Sofía Martínez', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                const Text('Consultó inventario', style: TextStyle(color: Colors.black, fontSize: 12),),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 255, 205, 220),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text('Inventario', style: TextStyle(color: Colors.black, fontSize: 11)),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('29 sep 2025 · 08:55 a.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

              ]
            )
          )
        ],
      ),
    );
  }
}