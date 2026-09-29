import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6E8ED),
      body: 
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', height: 210, width: 200,),
            SizedBox(height: 5,),
            SizedBox(
            width: 370,
            child: 
            TextField(decoration: InputDecoration(
            labelText: ('Usuario'), 
            border: OutlineInputBorder(),
            ),
            )
            ),
            SizedBox(height: 20,),
            SizedBox(
            width: 370,
            child: 
            TextField(decoration: InputDecoration(
            labelText: ('Contraseña'), 
            border: OutlineInputBorder(),
            ),
            )
            ),

            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {Navigator.pushReplacementNamed(context, '/dashboard');}, 
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFB85F83),
            foregroundColor: Colors.white,
            minimumSize: Size (300,50)
            ),
            child: 
            Text('Iniciar Sesion',)
            )
          ]
          
        ),
      ),
    );
  }
}