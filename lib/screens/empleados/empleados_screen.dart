import 'package:flutter/material.dart';

class EmpleadosScreen extends StatelessWidget {
  const EmpleadosScreen({super.key});

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
      
      const Text ('Usuarios', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
      const Text ('Administra a los usuarios del sistema'),
      Padding(padding: const 
      EdgeInsets.only(top:20),
     child: Row( 
        children: [
       const SizedBox(height: 30,),
      const SizedBox(width: 310,
      child: SearchBar(
        hintText: ('Buscar Usuario'),
        leading:  Icon (Icons.search)
        ),
      ),
       const SizedBox(width: 10,),
      IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_rounded)),
        ]
      )
      )
    ]
  ),

  
    ),
  ],

),



      );



    
  }
}
