class Endereco {
  String _idEndereco;
  String rua;
  String numero;
  String complemento;

  Endereco({this.rua, this.numero, this. complemento});

  Endereco.fromMap(Map<String, dynamic> dados) {
    fromMap(dados);
  }

  // ignore: unnecessary_getters_setters
  String get idEndereco => _idEndereco;

  // ignore: unnecessary_getters_setters
  set idEndereco(String id) {
    if ((id.runtimeType == String) && (id.isEmpty)) {
      return;
    }
    _idEndereco ??= id;
  }

  void fromMap(Map<String, dynamic> dados) {
    idEndereco = dados['idEndereco'];
    rua = dados['rua'];
    numero = dados['numero'];
    complemento = dados['complemento'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idEndereco': idEndereco,
      'rua': rua,
      'numero': numero,
      'complemento': complemento,
    };
  }

  @override
  String toString() => '$rua, $numero, $complemento';
}
