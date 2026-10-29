import 'package:flutter/material.dart';
import 'package:apparel_movil/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

  
class _LoginScreenState extends State<LoginScreen> {

  final _globalKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future <void> _login() async {
   if (!_globalKey.currentState!.validate()) return; 

   final autg = context.read<AuthProvider>();
   await autg.login(
      username: _usernameController.text.trim(),
      password: _passwordController.text
    );

    if (!mounted) return;
    if (autg.isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      final errorMessage = autg.errorMessage ?? 'Error de autenticación';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6E8ED),
      body: 
      Center(
        child: Form(
          key: _globalKey,  
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', height: 210, width: 200,),
            SizedBox(height: 5,),
            SizedBox(
            width: 370,
            child: 
            TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
            labelText: ('Usuario'), 
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
            ),
            )
            ),
            SizedBox(height: 20,),
            SizedBox(
            width: 370,
            child: 
            TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
            labelText: ('Contraseña'), 
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
            ),
            )
            ),

            SizedBox(height: 20,),
            FilledButton(
            onPressed: _login,
            style: FilledButton.styleFrom(
            backgroundColor: Color(0xFFB85F83),
            foregroundColor: Colors.white,
            minimumSize: Size (300,50)
            ),
            child: 
            Text('Iniciar Sesion',)
            )
          ]
          
        ),
      ),
    )
    );
  }
}