import 'package:flutter/material.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Padding(
          padding: const EdgeInsets.only(left: 10, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              
              const Text('Configuración', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
              const Text('Personaliza tu experiencia')
            ],

          ),
          ),

Padding(
  padding: const EdgeInsets.all(10),
         child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 390,
                child: Card(
                  color: const Color(0xFFF6E8ED),
                  
                  child: Padding(padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Notificaciones'),
                      const SizedBox(height: 15),

                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('Activar notificaciones'),
                      Switch(value: true, onChanged:(value) {} ),
                      ]
                      ),

                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                      const Text('Alertas de stock bajo'),
                      Switch(value: true, onChanged:(value) {} ),

                      ]
                      ),
                    ],
                  ),
                  ),
                ),
              )
            ],
          ),
),

Padding(
  padding: const EdgeInsets.all(10),
         child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 390,
                child: Card(
                  color: const Color(0xFFF6E8ED),
                  
                  child: Padding(padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Seguridad'),
                      const SizedBox(height: 15),

                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('Cambiar contraseña'),
                      const Icon(Icons.chevron_right)
                      ]
                      ),
                    ],
                  ),
                  ),
                ),
              )
            ],
          ),
),

Padding(
  padding: const EdgeInsets.all(10),
         child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 390,
                child: Card(
                  color: const Color(0xFFF6E8ED),
                  
                  child: Padding(padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Preferencias'),
                      const SizedBox(height: 15),

                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('Modo oscuro'),
                      Switch(value: false, onChanged:(value) {} ),
                      
                      ]
                      ),
                    ],
                  ),
                  ),
                ),
              )
            ],
          ),
),

Padding(padding: const 
      EdgeInsets.only(top:20, left: 15),
      child: 
      SizedBox(
      width: 380,
      child: ElevatedButton.icon (onPressed: () {Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);}, icon: Icon(Icons.logout),
      label: const Text('Cerrar sesión',),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 238, 181, 200),
        foregroundColor: Colors.black,
      ),
      ),
      ),
),
        ],

      ),



    );
  }
} 