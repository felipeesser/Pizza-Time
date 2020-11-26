import 'package:flutter/material.dart';

import 'package:pizza_time/modelo/pedido.dart';

/// Notifica os consumidores dessa classe sobre mudanças realizadas.
///
/// Dispara notificações quando o objeto dessa classe sofrer mudanças.
class PedidoNotifier extends ChangeNotifier {
  Pedido _pedidoAtual;

  Pedido get pedidoAtual => _pedidoAtual;

  set pedidoAtual(Pedido item) {
    _pedidoAtual = item;
    notifyListeners();
  }

  String get idPedidoAtual => _pedidoAtual.idPedido;

  String get idEnderecoPedidoAtual => _pedidoAtual.idEndereco;

  String get idUsuarioPedidoAtual => _pedidoAtual.idUsuario;

  String get pagamentoPedidoAtual => _pedidoAtual.pagamento;

  String get statusPedidoAtual => _pedidoAtual.statusPedido;

  set statusPedidoAtual(String status) => _pedidoAtual.statusPedido = status;

  Map<String, int> get idsItemQuantidade => {..._pedidoAtual.idsItemQuantidade};
}
