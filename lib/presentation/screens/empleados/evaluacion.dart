import 'package:flutter/material.dart';

class EvaluacionScreen extends StatelessWidget {
  const EvaluacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Evaluación de desempeño'),
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Contenido de la pantalla de evaluación de desempeño'),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Evaluación',
              ),
            ),
          ],
        ),
      ),

 
    );
  }
}