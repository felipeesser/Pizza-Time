import 'carrinho.dart';
import 'item_carrinho.dart';

class Pedido {
  String _idPedido;
  String _idUsuario;
  String _idEndereco;
  // statusPedido {'Na fila', 'Preparando', 'Pronto para entrega', 'A caminho', 'Entregue'}
  String statusPedido;
  // pagamento {'Dinheiro', 'Cartão de crédito', 'Cartão de débito'}
  String pagamento;
  // idsItemQuantidade: {idItem1: quantidadeItem1, ..., idItemN: quantidadeItemN,}
  Map<String, int> idsItemQuantidade;

  Pedido(
      {String idPedido,
      String idUsuario,
      String statusPedido,
      String pagamento,
      String idEndereco,
      Map<String, int> idsItemQuantidade}) {
    this.idPedido = idPedido;
    this.idUsuario = idUsuario;
    this.statusPedido = statusPedido;
    this.pagamento = pagamento;
    this.idEndereco = idEndereco;
    this.idsItemQuantidade = idsItemQuantidade;
  }

  Pedido.fromMap(Map<String, dynamic> dados) {
    fromMap(dados);
  }

  fromMap(Map<String, dynamic> dados) {
    idPedido = dados['idPedido'];
    idUsuario = dados['idUsuario'];
    statusPedido = dados['statusPedido'];
    pagamento = dados['pagamento'];
    idEndereco = dados['idEndereco'];
    // null caso caso a chave não exista ou o valor da chave seja null em dados;
    if (dados['idsItemQuantidade'].runtimeType == null) {
      idsItemQuantidade = null;
    } else {
      idsItemQuantidade = Map<String, int>.from(dados['idsItemQuantidade']);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'idPedido': idPedido,
      'idUsuario': idUsuario,
      'idEndereco': idEndereco,
      'statusPedido': statusPedido,
      'pagamento': pagamento,
      'idsItemQuantidade': idsItemQuantidade,
    };
  }

  // ignore: unnecessary_getters_setters
  String get idPedido => _idPedido;

  // ignore: unnecessary_getters_setters
  set idPedido(String id) {
    if ((id.runtimeType == String) && (id.isEmpty)) {
      return;
    }
    _idPedido ??= id;
  }

  // ignore: unnecessary_getters_setters
  String get idUsuario => _idUsuario;

  // ignore: unnecessary_getters_setters
  set idUsuario(String id) {
    if ((id.runtimeType == String) && (id.isEmpty)) {
      return;
    }
    _idUsuario ??= id;
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

  /// Preenche este pedido com os itens do [carrinho].
  ///
  /// Todos os itens que já presentes serão descartados e os novos serão
  /// adicionados.
  void idsItemQuantidadeFromCarrinho(Carrinho carrinho) {
    idsItemQuantidade = Map<String, int>();
    for (ItemCarrinho i in carrinho.itensCarrinho) {
      idsItemQuantidade.addAll({i.item.idItem: i.quantidade});
    }
  }
}
