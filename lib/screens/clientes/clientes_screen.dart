import 'package:flutter/material.dart';

class ClientesScreen extends StatelessWidget {
  const ClientesScreen({super.key});

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
                const Text('Clientes', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                const Text('Gestiona la información de tus clientes'),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 310,
                        child: SearchBar(
                          hintText: ('Buscar Cliente'),
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

              ]
            )
          )
        ],
      ),
    );
  }
}