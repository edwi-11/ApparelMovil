import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  
final Widget child;
final int currentIndex;

const AppLayout({super.key, required this.child, this.currentIndex=0,});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset('assets/images/logo.png', height: 120, width: 110,),
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

        body: child,

            bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                selectedItemColor: const Color (0xFFB85F83),
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                

               onTap: (index){
                if (index==0) {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                }

                 if (index==1) {
                  Navigator.pushReplacementNamed(context, '/clientes');
                }

                 if (index==2) {
                  Navigator.pushReplacementNamed(context, '/empleados');
                }

                 if (index==3) {
                  Navigator.pushReplacementNamed(context, '/ventas');
                }

                if (index==4) {
                  Navigator.pushReplacementNamed(context, routeName)
                }
               },



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

                    BottomNavigationBarItem(icon: Icon(Icons.description))
                ],
            ),



        );

    


  }
}