

import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset('assets/images/logo.png', height: 70, width: 70,),
            actions: [
                Padding( padding: const EdgeInsets.only(right: 15),
                child: Row(
                children: [ 
                    Icon (Icons.account_circle, color: Color(0xFFC47784), size:50 ),

                Icon(Icons.keyboard_arrow_down )
                ],
                ),
                ),
            ],
        ),

            bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: const Color.fromARGB(255, 239, 43, 207),
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                currentIndex: 0,
                items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home),
                    label: 'Inicio',
                    ),

                    BottomNavigationBarItem(icon: Icon(Icons.people),
                    label: 'Clientes',
                    ),

                    BottomNavigationBarItem(icon: Icon(Icons.person_2),
                    label: 'Usuarios'
                    ),

                    BottomNavigationBarItem(icon: Icon(Icons.analytics),
                    label: 'Ventas'
                    ),
                ],
            ),

        );

    


  }
}