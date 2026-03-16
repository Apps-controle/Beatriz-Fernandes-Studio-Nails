import 'package:flutter/material.dart';

void main() {
  runApp(const CRMApp());
}

class CRMApp extends StatelessWidget {
  const CRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRM Manicure',
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double totalEntradas = 0;
  double totalSaidas = 0;

  final List<double> entradas = [];
  final List<double> saidas = [];

  void adicionarEntrada(double valor) {
    setState(() {
      entradas.add(valor);
      totalEntradas = entradas.fold(0, (sum, item) => sum + item);
    });
  }

  void adicionarSaida(double valor) {
    setState(() {
      saidas.add(valor);
      totalSaidas = saidas.fold(0, (sum, item) => sum + item);
    });
  }

  @override
  Widget build(BuildContext context) {
    double lucro = totalEntradas - totalSaidas;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CRM Manicure Pro"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text("Total Entradas"),
                subtitle: Text("R\$ ${totalEntradas.toStringAsFixed(2)}"),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Total Saídas"),
                subtitle: Text("R\$ ${totalSaidas.toStringAsFixed(2)}"),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Lucro Líquido"),
                subtitle: Text("R\$ ${lucro.toStringAsFixed(2)}"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => mostrarDialogEntrada(context),
              child: const Text("Adicionar Entrada"),
            ),
            ElevatedButton(
              onPressed: () => mostrarDialogSaida(context),
              child: const Text("Adicionar Saída"),
            ),
          ],
        ),
      ),
    );
  }

  void mostrarDialogEntrada(BuildContext context) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova Entrada"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Valor"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              double valor = double.tryParse(controller.text) ?? 0;
              adicionarEntrada(valor);
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          )
        ],
      ),
    );
  }

  void mostrarDialogSaida(BuildContext context) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova Saída"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Valor"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              double valor = double.tryParse(controller.text) ?? 0;
              adicionarSaida(valor);
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          )
        ],
      ),
    );
  }
}