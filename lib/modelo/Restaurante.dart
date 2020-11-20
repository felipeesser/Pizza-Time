class Restaurante {
  String _telefone;
  bool _aberto;
  String _idDono;
  Restaurante();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idDono": this._idDono,
      "aberto": this._aberto,
      "telefone": this._telefone
    };

    return map;
  }

  String get idDono => idDono;

  set idDono(String value) {
    _idDono = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  bool get aberto => _aberto;

  set aberto(bool value) {
    _aberto = value;
  }


  Restaurante.fromMap(Map<String, dynamic> data) {
    aberto = data['aberto'];
    telefone = data['telefone'];
    idDono = data['idDono'];
  }
}

