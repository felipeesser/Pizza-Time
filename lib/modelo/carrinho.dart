import 'item_carrinho.dart';

// NOTE - essa classe não vai para o firestore
class Carrinho {
  List<ItemCarrinho> itensCarrinho;

  Carrinho() {
    itensCarrinho = List<ItemCarrinho>();
  }

  int get length {
    int soma = 0;
    for (var item in itensCarrinho) {
      soma += item.quantidade;
    }
    return soma;
  }

  double get precoTotal {
    double soma = 0;
    for (ItemCarrinho i in itensCarrinho) {
      soma += i.total;
    }
    return soma;
  }
}
