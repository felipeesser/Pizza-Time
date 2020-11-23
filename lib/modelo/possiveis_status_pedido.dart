/// Representação dos possíveis status de um pedido.
abstract class PossiveisStatusPedido {
  static const String naFila = 'Na fila';
  static const String preparando = 'Preparando';
  static const String prontoParaEntrega = 'Pronto para entrega';
  static const String aCaminho = 'A caminho';
  static const String entregue = 'Entregue';

  static List<String> get values => const [
        PossiveisStatusPedido.naFila,
        PossiveisStatusPedido.preparando,
        PossiveisStatusPedido.prontoParaEntrega,
        PossiveisStatusPedido.aCaminho,
        PossiveisStatusPedido.entregue,
      ];
}
