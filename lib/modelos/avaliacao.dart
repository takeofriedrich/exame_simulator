class Avaliacao {
  String _nome = 'Avaliação 1';
  int _peso = 30;
  double _nota = 7.0;

  Avaliacao();

  Avaliacao.fromJson(Map<String, String> json) {
    this._nome = json['nome'];
    this._peso = int.parse(json['peso']);
    this._nota = double.parse(json['nota']);
  }

  Map<String, String> toJson() {
    Map<String, String> json = Map<String, String>();
    json['nome'] = this._nome;
    json['peso'] = this._peso.toString();
    json['nota'] = this._nota.toString();
    return json;
  }

  int get peso => _peso;

  set peso(int value) => _peso = value;

  double get nota => _nota;

  set nota(double value) => _nota = value;

  String get nome => _nome;
  set nome(String value) => _nome = value;

  double get ponderada => _nota * (_peso / 100);
}
