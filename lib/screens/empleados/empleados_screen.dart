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
      ),

      
Padding(padding: const 
      EdgeInsets.only(top:20),
      child: 
      SizedBox(
      width: 380,
      child: ElevatedButton.icon (onPressed: () {}, icon: Icon(Icons.add),
      label: const Text('Nuevo usuario',),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 238, 181, 200),
        foregroundColor: Colors.black,
      ),
      ),
      ),
),

Padding(
  padding: const EdgeInsets.only(top:20),
  child: SizedBox(
    width: 370,
    height:70,
    child: ElevatedButton(onPressed: () {}, 
    child: Row(
      children: [
        const Icon(Icons.account_circle, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),

        
        const SizedBox(width: 15,),

        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text ('Leyani Chavez', style: TextStyle(color:(Colors.black)),),
            Text ('Administrador', style: TextStyle(color:(Colors.black),),),
          ],
        ),

        const Spacer(),

        const Text('Activo', style: TextStyle(color: (Colors.green))),

        const Spacer(),
         
        const Icon(Icons.chevron_right)

      ],
    ),
    
  )
  
  ),
),

Padding(
  padding: const EdgeInsets.only(top:20),
  child: SizedBox(
    width: 370,
    height:70,
    child: ElevatedButton(onPressed: () {}, 
    child: Row(
      children: [
        const Icon(Icons.account_circle, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),

        
        const SizedBox(width: 15,),

        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text ('Leyani Chavez', style: TextStyle(color:(Colors.black)),),
            Text ('Administrador', style: TextStyle(color:(Colors.black),),),
          ],
        ),

        const Spacer(),

        const Text('Activo', style: TextStyle(color: (Colors.green))),

        const Spacer(),
         
        const Icon(Icons.chevron_right)

      ],
    ),
    
  )
  
  ),
),

Padding(
  padding: const EdgeInsets.only(top:20),
  child: SizedBox(
    width: 370,
    height:70,
    child: ElevatedButton(onPressed: () {}, 
    child: Row(
      children: [
        const Icon(Icons.account_circle, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),

        
        const SizedBox(width: 15,),

        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text ('Leyani Chavez', style: TextStyle(color:(Colors.black)),),
            Text ('Administrador', style: TextStyle(color:(Colors.black),),),
          ],
        ),

        const Spacer(),

        const Text('Activo', style: TextStyle(color: (Colors.green))),

        const Spacer(),
         
        const Icon(Icons.chevron_right)

      ],
    ),
    
  )
  
  ),
),
Padding(
  padding: const EdgeInsets.only(top:20),
  child: SizedBox(
    width: 370,
    height:70,
    child: ElevatedButton(onPressed: () {}, 
    child: Row(
      children: [
        const Icon(Icons.account_circle, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),

        
        const SizedBox(width: 15,),

        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text ('Leyani Chavez', style: TextStyle(color:(Colors.black)),),
            Text ('Administrador', style: TextStyle(color:(Colors.black),),),
          ],
        ),

        const Spacer(),

        const Text('Activo', style: TextStyle(color: (Colors.green))),

        const Spacer(),
         
        const Icon(Icons.chevron_right)

      ],
    ),
    
  )
  
  ),
),



//Padding(padding: const EdgeInsets.only(top:20),

//child: SizedBox(
  //width: 200,
  //height: 100,

  //child: 
//),


//),

    ]
  ),
    ),
  ],

),



      );



    
  }
}
