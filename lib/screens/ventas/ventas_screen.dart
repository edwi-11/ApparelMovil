import 'package:flutter/material.dart';

class VentasScreen extends StatelessWidget {
  const VentasScreen({super.key});

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
                const Text('Ventas', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                const Text('Consulta y sigue el historial de ventas'),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 196, 119, 148),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Todas', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Hoy', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Semana', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Mes', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 310,
                        child: SearchBar(
                          hintText: ('Buscar Venta'),
                          leading: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_alt_rounded),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () => _mostrarDetalleVenta(
                        context,
                        id: '#000124',
                        fecha: '10 Sep 2025 - 3:42 p.m.',
                        monto: 'C\$ 1,250',
                        estado: 'Completada',
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.receipt_long,
                            size: 40,
                            color: Color.fromARGB(255, 245, 120, 162),
                          ),
                          const SizedBox(width: 15),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('#000124', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Text('10 Sep 2025 - 3:42 p.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('C\$ 1,250', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Text('Completada', style: TextStyle(color: Colors.green, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () => _mostrarDetalleVenta(
                        context,
                        id: '#000123',
                        fecha: '10 Sep 2025 - 2:37 p.m.',
                        monto: 'C\$ 890',
                        estado: 'Completada',
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.receipt_long,
                            size: 40,
                            color: Color.fromARGB(255, 245, 120, 162),
                          ),
                          const SizedBox(width: 15),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('#000123', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Text('10 Sep 2025 - 2:37 p.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('C\$ 890', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Text('Completada', style: TextStyle(color: Colors.green, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () => _mostrarDetalleVenta(
                        context,
                        id: '#000122',
                        fecha: '10 Sep 2025 - 1:15 p.m.',
                        monto: 'C\$ 2,450',
                        estado: 'Completada',
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.receipt_long,
                            size: 40,
                            color: Color.fromARGB(255, 245, 120, 162),
                          ),
                          const SizedBox(width: 15),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('#000122', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Text('10 Sep 2025 - 1:15 p.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('C\$ 2,450', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Text('Completada', style: TextStyle(color: Colors.green, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 370,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () => _mostrarDetalleVenta(
                        context,
                        id: '#000121',
                        fecha: '10 Sep 2025 - 11:03 a.m.',
                        monto: 'C\$ 980',
                        estado: 'Completada',
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.receipt_long,
                            size: 40,
                            color: Color.fromARGB(255, 245, 120, 162),
                          ),
                          const SizedBox(width: 15),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('#000121', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Text('10 Sep 2025 - 11:03 a.m.', style: TextStyle(color: Colors.black, fontSize: 11),),
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('C\$ 980', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Text('Completada', style: TextStyle(color: Colors.green, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                ),

              ]
            )
          )
        ],
      ),
    );
  }

  void _mostrarDetalleVenta(
    BuildContext context, {
    required String id,
    required String fecha,
    required String monto,
    required String estado,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.receipt_long,
                    size: 40,
                    color: Color.fromARGB(255, 245, 120, 162),
                  ),
                  const SizedBox(width: 15),
                  Text('Venta $id', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                ],
              ),
              const SizedBox(height: 20),
              _filaDetalle('Fecha', fecha),
              _filaDetalle('Estado', estado),
              _filaDetalle('Total', monto),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 196, 119, 148),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cerrar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _filaDetalle(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo, style: const TextStyle(color: Colors.black54)),
          Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}