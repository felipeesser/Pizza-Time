class Item {
  String _idItem;
  String nome;
  String descricao;
  double preco;
  String imagem;
  String tipo;

  Item();

  Item.fromMap(Map<String, dynamic> data) {
    fromMap(data);
  }

  // ignore: unnecessary_getters_setters
  String get idItem => _idItem;

  // ignore: unnecessary_getters_setters
  set idItem(String id) {
    _idItem ??= id;
  }

  fromMap(Map<String, dynamic> data) {
    idItem = data['idItem'];
    nome = data['nome'];
    descricao = data['descricao'];
    preco = data['preco'];
    imagem = data['urlImagem'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idItem': _idItem,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'urlImagem': imagem,
    };
  }
}
