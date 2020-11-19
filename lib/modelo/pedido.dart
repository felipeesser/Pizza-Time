import 'carrinho.dart';
import 'item_carrinho.dart';
import 'endereco.dart';

class Pedido {
  String _idPedido;
  String _idUsuario;
  // statusPedido {'Na fila', 'Preparando', 'Pronto para entrega', 'A caminho', 'Entregue'}
  String statusPedido;
  // pagamento {'Dinheiro', 'Cartão de crédito', 'Cartão de débito'}
  String pagamento;
  Endereco endereco;
  // idsItemQuantidade: {idItem1: quantidadeItem1, ..., idItemN: quantidadeItemN,}
  Map<String, int> idsItemQuantidade;

  Pedido({this.statusPedido, this.pagamento, this.endereco});

  Pedido.fromMap(Map<String, dynamic> dados) {
    fromMap(dados);
  }

  fromMap(Map<String, dynamic> dados) {
    idPedido = dados['idPedido'];
    idUsuario = dados['idUsuario'];
    statusPedido = dados['statusPedido'];
    pagamento = dados['pagamento'];
    endereco = Endereco.fromMap(dados['endereco']);
    idsItemQuantidade = dados['idsItemQuantidade'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idPedido': idPedido,
      'idUsuario': idUsuario,
      'statusPedido': statusPedido,
      'pagamento': pagamento,
      'endereco': endereco.toMap(),
      'idsItemQuantidade': idsItemQuantidade,
    };
  }

  // ignore: unnecessary_getters_setters
  String get idPedido => _idPedido;

  // ignore: unnecessary_getters_setters
  set idPedido(String id) {
    _idPedido ??= id;
  }

  // ignore: unnecessary_getters_setters
  String get idUsuario => _idUsuario;

  // ignore: unnecessary_getters_setters
  set idUsuario(String id) {
    _idUsuario ??= id;
  }

  void itensPedidoFromCarrinho(Carrinho carrinho) {
    for (ItemCarrinho i in carrinho.itensCarrinho) {
      idsItemQuantidade.addAll({i.item.idItem: i.quantidade});
    }
  }

  // TODO - continuar implementação
}
