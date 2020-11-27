import 'item_carrinho.dart';

// NOTE - essa classe não vai para o firestore
/// Carrnho de itens selecionados pelo usuário
class Carrinho {
  List<ItemCarrinho> itensCarrinho;

  /// Cria um carriho sem itens.
  Carrinho() {
    itensCarrinho = List<ItemCarrinho>();
  }

  /// O total de unidades de todos os itens do carrinho.
  int get quantidadeItens {
    int soma = 0;
    for (var item in itensCarrinho) {
      soma += item.quantidade;
    }
    return soma;
  }

  /// O preco total de todos os itens no carrinho.
  double get precoTotal {
    double soma = 0;
    for (ItemCarrinho i in itensCarrinho) {
      soma += i.total;
    }
    return soma;
  }
}
