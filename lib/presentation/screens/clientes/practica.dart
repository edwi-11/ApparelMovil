import 'package:flutter/material.dart';

class Lista extends StatelessWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

     body: SearchBar(
      hintText: ('Buscar Productos'),
     
     ),

      TextField(
        decoration: InputDecoration(
          label: Text()
        ),
        
        )
    );
  }
}