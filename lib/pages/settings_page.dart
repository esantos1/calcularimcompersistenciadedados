import 'package:calcularimcompersistenciadedados/classes/settings.dart';
import 'package:calcularimcompersistenciadedados/components/custom_text_field.dart';
import 'package:calcularimcompersistenciadedados/repositories/settings_repository.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsRepository repository;
  var settings = Settings?.empty();

  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    repository = await SettingsRepository.loadData();
    settings = repository.getData();

    nomeController.text = settings.nome;
    alturaController.text = settings.altura.toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: nomeController,
                labelText: 'Nome',
                validator: validatorInputs,
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: alturaController,
                labelText: 'Altura',
                keyboardType: TextInputType.number,
                validator: validatorInputs,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onSaveButtonClicked,
                      child: Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSaveButtonClicked() {
    if (formKey.currentState!.validate()) {
      setState(() {
        settings.nome = nomeController.text;
        settings.altura = double.parse(alturaController.text);

        repository.save(settings);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Dados salvos com sucesso'),
      ));

      Navigator.pop(context);
    }
  }

  String? validatorInputs(String? value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo não pode ser vazio';
    }

    return null;
  }
}
