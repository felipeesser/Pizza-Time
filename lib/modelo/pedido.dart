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
  String valor;
  // idsItemQuantidade: {idItem1: quantidadeItem1, ..., idItemN: quantidadeItemN,}
  Map<String, int> idsItemQuantidade;

  Pedido({
      String idUsuario,
      String statusPedido,
      String pagamento,
      String idEndereco,
      String valor,
      Map<String, int> idsItemQuantidade}) {
    this.idPedido = idPedido;
    this.idUsuario = idUsuario;
    this.valor = valor;
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
    valor = dados['valor'];
    // null caso caso a chave não exista ou o valor da chave seja null em dados;
    if (dados['idsItemQuantidade'].runtimeType == null) {
      idsItemQuantidade = null;
    } else {
      // resolve o retorno do banco de dados que vem como _internalLinkedHashMap
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
      'valor': valor,
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

  /// Preenche este pedido com os itens e o valor do [carrinho].
  ///
  /// Todos os itens que já presentes serão descartados e os novos serão
  /// adicionados.
  void idsItemQuantidadeFromCarrinho(Carrinho carrinho) {
    idsItemQuantidade = Map<String, int>();
    for (ItemCarrinho i in carrinho.itensCarrinho) {
      idsItemQuantidade.update(
        i.item.idItem,
        (valorAtual) => valorAtual + i.quantidade,
        ifAbsent: () => i.quantidade,
      );
    }
    valor = carrinho.precoTotal.toString();
  }
}
