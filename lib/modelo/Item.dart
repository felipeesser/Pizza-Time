class Item {
  String _idItem;
  String nome;
  String descricao;
  double preco;
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

  fromMap(Map<String, dynamic> dados) {
    idItem = dados['idItem'];
    nome = dados['nome'];
    descricao = dados['descricao'];
    preco = dados['preco'];
    imagem = dados['urlImagem'];
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
