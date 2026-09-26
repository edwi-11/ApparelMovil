import 'package:flutter/material.dart';

class VentasScreen extends StatelessWidget {
  const VentasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
          padding: const EdgeInsets.only(left:10, top:30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const Text('Ventas', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
              const Text('Consulta y sigue el historial de ventas'),

              Padding(padding: const 
              EdgeInsets.only(top:20),
              child: SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ElevatedButton(onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 196, 119, 148),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Todas'),
                    ),

                    const SizedBox(width: 10,),

                    ElevatedButton(onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                    ),
                    child: const Text('Hoy'),
                    ),

                    const SizedBox(width: 10,),

                    ElevatedButton(onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                    ),
                    child: const Text('Semana'),
                    ),

                    const SizedBox(width: 10,),

                    ElevatedButton(onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                    ),
                    child: const Text('Mes'),
                    ),
                  ],
                ),
              ),
              ),

              Padding(padding: const 
              EdgeInsets.only(top:20),
              child: Row( 
                 children: [
                const SizedBox(width: 310,
                child: SearchBar(
                  hintText: ('Buscar venta'),
                  leading:  Icon (Icons.search)
                  ),
                ),
                 const SizedBox(width: 10,),
                IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_rounded)),
                  ]
                )
                ),

            ]
          )
        )
        ],
      ),
    );
  }
}