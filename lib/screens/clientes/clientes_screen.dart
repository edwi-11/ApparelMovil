import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf7f3),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 25),

              // TÍTULO
              const Text(
                'Clientes',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF171717),
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'Gestiona la información de tus clientes',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF444444),
                ),
              ),

              const SizedBox(height: 20),

              // BUSCADOR
              Row(
                children: [

                  Expanded(
                    child: TextField(
                      controller: buscarController,
                      onChanged: (valor) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFFFFCFA),

                        hintText: 'Buscar cliente...',

                        prefixIcon: const Icon(
                          Icons.search,
                          size: 28,
                          color: Color(0xFF72234B),
                        ),

                        contentPadding:
                            const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 15,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Color(0xFFE1D8D4),
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Color(0xFFE1D8D4),
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Color(0xFFD6538C),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // BOTÓN FILTRO
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_list,
                      color: Color(0xFF7C2452),
                      size: 28,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFFFE9F1),
                      fixedSize: const Size(62, 62),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                        side: const BorderSide(
                          color: Color(0xFFE4C9D4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // BOTÓN NUEVO CLIENTE
              SizedBox(
                width: double.infinity,
                height: 62,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFE889B1),
                    foregroundColor:
                        const Color(0xFF321322),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    children: [

                      SizedBox(width: 15),

                      Icon(
                        Icons.add,
                        size: 30,
                      ),

                      SizedBox(width: 18),

                      Text(
                        'Nuevo cliente',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // LISTA DE CLIENTES
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.only(bottom: 20),
                  itemCount: clientesFiltrados.length,
                  itemBuilder: (context, index) {

                    final cliente =
                        clientesFiltrados[index];

                    // BOTÓN DEL CLIENTE
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 12),

                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFFFCFA),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20),
                            side: const BorderSide(
                              color: Color(0xFFE1D8D4),
                            ),
                          ),
                        ),

                        child: Row(
                          children: [

                            // ICONO
                            Icon(
                              Icons.account_circle,
                              color:
                                  const Color(0xFFD6538C),
                              size: 50,
                            ),

                            const SizedBox(width: 14),

                            // INFORMACIÓN
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    cliente['nombre']!,
                                    style:
                                        const TextStyle(
                                      fontSize: 17,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    'Cliente ${cliente['numero']}',
                                    style:
                                        const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  const SizedBox(height: 2),

                                  Text(
                                    cliente['telefono']!,
                                    style:
                                        const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 6),

Row(
  children: [
    Icon(
      Icons.circle,
      size: 10,
      color: cliente['estado'] == 'inactivo'
          ? const Color.fromARGB(255, 175, 4, 4)
          : const Color.fromARGB(255, 3, 221, 21),
    ),

    const SizedBox(width: 6),

    Text(
      cliente['estado']!,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: cliente['estado'] == 'Activo'
            ? const Color.fromARGB(255, 3, 221, 21)
            : const Color.fromARGB(255, 175, 4, 4),
      ),
    ),
  ],
),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.chevron_right,
                              color: Color(0xFFD6538C),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}