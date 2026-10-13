import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget _tarjeta(IconData icono, String titulo, String valor, String cambio, Color colorCambio) {
    return Expanded(
      child: SizedBox(
        height: 130,
        child: ElevatedButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icono, size: 30, color: const Color.fromARGB(255, 245, 120, 162)),
              const SizedBox(height: 6),
              Text(titulo, style: const TextStyle(color: Colors.black, fontSize: 12)),
              Text(valor, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
              Text(cambio, style: TextStyle(color: colorCambio, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _barra(String dia, double alto) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25,
          height: alto,
          color: const Color.fromARGB(255, 224, 143, 171),
        ),
        const SizedBox(height: 5),
        Text(dia, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _venta(String numero, String fecha, String monto) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [
              const Icon(Icons.receipt_long, size: 40, color: Color.fromARGB(255, 245, 120, 162)),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(numero, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  Text(fecha, style: const TextStyle(color: Colors.black)),
                ],
              ),
              const Spacer(),
              Text(monto, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hola, Ricardo', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
                const Text('Aquí tienes un resumen de tu tienda'),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      _tarjeta(Icons.lock_outline, 'Total de ventas', 'C\$ 48,320', '↑ 12%', Colors.green),
                      const SizedBox(width: 10),
                      _tarjeta(Icons.group, 'Clientes registrados', '248', '↑ 8%', Colors.green),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      _tarjeta(Icons.checkroom, 'Productos en stock', '1,245', '↑ 5%', Colors.green),
                      const SizedBox(width: 10),
                      _tarjeta(Icons.person, 'Usuarios activos', '5', '→ 0%', Colors.grey),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Ventas de la semana', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 130,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _barra('Lun', 25),
                              _barra('Mar', 35),
                              _barra('Mié', 45),
                              _barra('Jue', 30),
                              _barra('Vie', 40),
                              _barra('Sáb', 65),
                              _barra('Dom', 100),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Últimas ventas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Ver todas >', style: TextStyle(color: Color.fromARGB(255, 196, 119, 148))),
                    ],
                  ),
                ),

                _venta('#000124', '10 Sep 2025 - 3:42 p.m.', 'C\$ 1,250'),
                _venta('#000123', '10 Sep 2025 - 2:37 p.m.', 'C\$ 890'),
                _venta('#000122', '9 Sep 2025 - 1:15 p.m.', 'C\$ 2,450'),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}