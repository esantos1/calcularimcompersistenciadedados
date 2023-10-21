import 'package:calcularimcompersistenciadedados/classes/pessoa.dart';
import 'package:calcularimcompersistenciadedados/components/custom_text_field.dart';
import 'package:calcularimcompersistenciadedados/pages/settings_page.dart';
import 'package:calcularimcompersistenciadedados/repositories/settings_repository.dart';
import 'package:flutter/material.dart';

enum _MenuValues {
  settings,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isImcCalculate = false;
  double imc = 0.0;
  String resultadoFinal = "";

  final pesoController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        actions: [
          PopupMenuButton<_MenuValues>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _MenuValues.settings,
                child: Text('Configurações'),
              ),
            ],
            onSelected: onPopUpMenuItemSelected,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: pesoController, labelText: 'Peso'),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isImcCalculate ? null : calcImcMostrarResult,
                    child: Text('Calcular'),
                  ),
                ),
              ],
            ),
            isImcCalculate ? widgetMostrarResultado() : SizedBox(),
            isImcCalculate
                ? Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: novoCalc,
                          child: Text('Fazer novo calculo'),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void calcImcMostrarResult() async {
    final repository = await SettingsRepository.loadData();
    final settings = repository.getData();

    final nome = settings.nome;
    double peso = 0.0, altura = settings.altura;
    bool mostrarResultado;

    FocusScope.of(context).unfocus();

    try {
      peso = double.parse(pesoController.text);
      mostrarResultado = true;
    } catch (e) {
      showErrorDialog(
          'Insira um peso válido. Este campo aceita apenas números e vírgulas!');

      mostrarResultado = false;
    }

    Pessoa pessoa = Pessoa(nome, peso, altura);

    setState(() {
      imc = pessoa.calcularImc();

      if (imc < 18.5) {
        resultadoFinal = "Magreza";
      } else if (imc >= 18.5 && imc < 25.0) {
        resultadoFinal = "Normal";
      } else if (imc >= 25.0 && imc < 30.0) {
        resultadoFinal = "Sobrepeso";
      } else if (imc >= 30.0 && imc < 35.0) {
        resultadoFinal = "Obesidade grau I";
      } else if (imc >= 35.0 && imc < 40.0) {
        resultadoFinal = "Obesidade grau II";
      } else {
        resultadoFinal = "Obesidade grau III";
      }

      isImcCalculate = mostrarResultado;
    });
  }

  void showErrorDialog(String textoErro) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textoErro),
          duration: Duration(seconds: 3),
        ),
      );

  Widget widgetMostrarResultado() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              imc.toStringAsFixed(1),
              style: TextStyle(color: Colors.black38, fontSize: 16),
            ),
            Text(resultadoFinal, style: TextStyle(fontSize: 32)),
          ],
        ),
      );

  void novoCalc() {
    setState(() => isImcCalculate = false);

    // nomeController.text = "";
    pesoController.text = "";
    // alturaController.text = "";
  }

  void onPopUpMenuItemSelected(value) {
    switch (value) {
      case _MenuValues.settings:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;
    }
  }
}
