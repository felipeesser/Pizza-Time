/// Representação dos possiveis métodos de pagamento aceitos.
abstract class PossiveisFormasPagamento {
  static const String dinheiro = 'Dinheiro';
  static const String cartaoCredito = 'Cartão de Crédito';
  static const String cartaoDebito = 'Cartão de Débito';

  static List<String> get values => const [
        PossiveisFormasPagamento.dinheiro,
        PossiveisFormasPagamento.cartaoCredito,
        PossiveisFormasPagamento.cartaoDebito,
      ];
}
