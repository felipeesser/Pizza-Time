class Endereco {
  String _idEndereco;
  String rua;
  String numero;
  String complemento;

  Endereco({String idEndereco, String rua, String numero, String complemento}) {
    this.idEndereco = idEndereco;
    this.rua = rua;
    this.numero = numero;
    this.complemento = complemento;
  }

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
    rua = dados['rua'];
    numero = dados['numero'];
    complemento = dados['complemento'];
  }

  Map<String, dynamic> toMap() {
    return {
      'rua': rua,
      'numero': numero,
      'complemento': complemento,
    };
  }

  @override
  String toString() => 'Rua: $rua, $numero, Complemento: $complemento';
}
