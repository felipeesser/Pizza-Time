/// Representação dos métodos de pagamento aceitos.
abstract class PossiveisFormasPagamento {
  static const String dinheiro = 'Dinheiro';
  static const String cartaoCredito = 'Cartão de Crédito';
  static const String cartaoDebito = 'Cartão de Débito';

  static List<String> get values => [
        PossiveisFormasPagamento.dinheiro,
        PossiveisFormasPagamento.cartaoCredito,
        PossiveisFormasPagamento.cartaoDebito,
      ];
}
