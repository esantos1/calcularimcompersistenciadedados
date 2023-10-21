class Pessoa {
  late String _nome;
  late double _peso;
  late double _altura;

  Pessoa(this._nome, this._peso, this._altura);

  String get nome => _nome;
  set nome(String nome) => _nome = nome;

  double get peso => _peso;
  set peso(double peso) => _peso = peso;

  double get altura => _altura;
  set altura(double altura) => _altura = altura;

  double calcularImc() => peso / (altura * altura);
}
