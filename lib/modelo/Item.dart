class Item {
  String _idItem;
  String nome;
  String descricao;
  String preco;
  String imagem;
  String tipo;

  Item({this.nome,  this.descricao, this.preco, this.imagem, this.tipo});

  Item.fromMap(Map<String, dynamic> dados) {
    fromMap(dados);
  }

  // ignore: unnecessary_getters_setters
  String get idItem => _idItem;

  // ignore: unnecessary_getters_setters
  set idItem(String id) {
    _idItem ??= id;
  }

  void fromMap(Map<String, dynamic> dados) {
    idItem = dados['idItem'];
    nome = dados['nome'];
    descricao = dados['descricao'];
    preco = dados['preco'];
    imagem = dados['imagem'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idItem': _idItem,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'imagem': imagem,
    };
  }
}
