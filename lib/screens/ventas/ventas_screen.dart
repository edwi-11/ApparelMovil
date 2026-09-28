import 'package:flutter/material.dart';

class VentasScreen extends StatelessWidget {
  const VentasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
          padding: const EdgeInsets.only(left:10, right:10, top:30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const Text('Ventas', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
              const Text('Consulta y sigue el historial de ventas'),

              Padding(padding: const 
              EdgeInsets.only(top:20),
              child: SizedBox(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                    child: ElevatedButton(onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 196, 119, 148),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      overlayColor: Colors.transparent,
                    ),
                    child: const Text('Todas'),
                    ),
                    ),

                    const SizedBox(width: 10,),

                    Expanded(
                    child: ElevatedButton(onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      overlayColor: Colors.transparent,
                    ),
                    child: const Text('Hoy'),
                    ),
                    ),

                    const SizedBox(width: 10,),

                    Expanded(
                    child: ElevatedButton(onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      overlayColor: Colors.transparent,
                    ),
                    child: const Text('Semana'),
                    ),
                    ),

                    const SizedBox(width: 10,),

                    Expanded(
                    child: ElevatedButton(onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      overlayColor: Colors.transparent,
                    ),
                    child: const Text('Mes'),
                    ),
                    ),
                  ],
                ),
              ),
              ),

              Padding(padding: const 
              EdgeInsets.only(top:20),
              child: Row( 
                 children: [
                Expanded(
                child: SizedBox(
                  height: 70,
                  child: SearchBar(
                    hintText: ('Buscar venta'),
                    leading:  Icon (Icons.search),
                    enabled: false,
                    constraints: const BoxConstraints(minHeight: 70),
                    ),
                  ),
                ),
                 const SizedBox(width: 10,),
                IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_rounded)),
                  ]
                )
                ),

              Padding(
                padding: const EdgeInsets.only(top:20),
                child: SizedBox(
                  width: double.infinity,
                  height:70,
                  child: ElevatedButton(onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.receipt_long, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),
                      const SizedBox(width: 15,),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text ('#000124', style: TextStyle(color:(Colors.black), fontWeight: FontWeight.bold),),
                          Text ('10 Sep 2025 - 3:42 p.m.', style: TextStyle(color:(Colors.black)),),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('C\$ 1,250', style: TextStyle(color:(Colors.black), fontWeight: FontWeight.bold),),
                          Text('Completada', style: TextStyle(color: (Colors.green))),
                        ],
                      ),
                      const SizedBox(width: 10,),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                )
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:20),
                child: SizedBox(
                  width: double.infinity,
                  height:70,
                  child: ElevatedButton(onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.receipt_long, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),
                      const SizedBox(width: 15,),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text ('#000123', style: TextStyle(color:(Colors.black), fontWeight: FontWeight.bold),),
                          Text ('10 Sep 2025 - 2:37 p.m.', style: TextStyle(color:(Colors.black)),),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('C\$ 890', style: TextStyle(color:(Colors.black), fontWeight: FontWeight.bold),),
                          Text('Completada', style: TextStyle(color: (Colors.green))),
                        ],
                      ),
                      const SizedBox(width: 10,),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                )
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:20),
                child: SizedBox(
                  width: double.infinity,
                  height:70,
                  child: ElevatedButton(onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.receipt_long, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),
                      const SizedBox(width: 15,),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text ('#000122', style: TextStyle(color:(Colors.black), fontWeight: FontWeight.bold),),
                          Text ('10 Sep 2025 - 1:15 p.m.', style: TextStyle(color:(Colors.black)),),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('C\$ 2,450', style: TextStyle(color:(Colors.black), fontWeight: FontWeight.bold),),
                          Text('Completada', style: TextStyle(color: (Colors.green))),
                        ],
                      ),
                      const SizedBox(width: 10,),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                )
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:20),
                child: SizedBox(
                  width: double.infinity,
                  height:70,
                  child: ElevatedButton(onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.receipt_long, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),
                      const SizedBox(width: 15,),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text ('#000121', style: TextStyle(color:(Colors.black), fontWeight: FontWeight.bold),),
                          Text ('10 Sep 2025 - 11:03 a.m.', style: TextStyle(color:(Colors.black)),),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('C\$ 980', style: TextStyle(color:(Colors.black), fontWeight: FontWeight.bold),),
                          Text('Completada', style: TextStyle(color: (Colors.green))),
                        ],
                      ),
                      const SizedBox(width: 10,),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                )
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