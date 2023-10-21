class Settings {
  late String _nome;
  late double _altura;

  Settings(this._nome, this._altura);

  Settings.empty() {
    _nome = '';
    _altura = 0;
  }

  String get nome => _nome;

  set nome(String nome) => _nome = nome;

  double get altura => _altura;

  set altura(double altura) => _altura = altura;
}
