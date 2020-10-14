// TODO - remover este arquivo
// STUB - arquivo com dados para teste

Carrinho carrinhoTEMP = Carrinho();

class ItemPedido {
  String nome;
  double valor;
  int quantidade;

  ItemPedido({this.nome, this.valor, this.quantidade});

  double get subtotal {
    return valor * quantidade;
  }

  @override
  String toString() {
    return 'nome: ${nome??''} val: ${valor??''} qtd: ${quantidade??''}';
  }
}

class Carrinho {
  static final String moeda = 'R\$';

  List<ItemPedido> itensPedido = [
    ItemPedido(nome: "aabbccda", valor: 1.0, quantidade: 1),
    ItemPedido(nome: "aabbccdb", valor: 3.0, quantidade: 3),
    ItemPedido(nome: "aabbccdc", valor: 4.5, quantidade: 1),
    ItemPedido(nome: "aabbccdd", valor: 1.7, quantidade: 3),
    ItemPedido(nome: "aabbccde", valor: 2.2, quantidade: 2),
    ItemPedido(nome: "aabbccdf", valor: 8.0, quantidade: 6),
    ItemPedido(nome: "aabbccdg", valor: 5.8, quantidade: 1),
    ItemPedido(nome: "aabbccdh", valor: 4.0, quantidade: 4),
    ItemPedido(nome: "aabbccdi", valor: 5.8, quantidade: 1),
    ItemPedido(nome: "aabbccdj", valor: 3.9, quantidade: 2),
    ItemPedido(nome: "aabbccdk", valor: 5.6, quantidade: 2),
    ItemPedido(nome: "aabbccdl", valor: 8.4, quantidade: 1),
    ItemPedido(nome: "aabbccdm", valor: 4.8, quantidade: 4),
    ItemPedido(nome: "aabbccdn", valor: 3.5, quantidade: 3),
    ItemPedido(nome: "aabbccdo", valor: 1.9, quantidade: 2),
    ItemPedido(nome: "aabbccdp", valor: 2.7, quantidade: 4),
    ItemPedido(nome: "aabbccdq", valor: 1.2, quantidade: 1),
  ];

  double get subtotal {
    double aux = 0;
    for (var item in itensPedido) {
      aux += item.subtotal;
    }
    return aux;
  }

  int get length {
    return itensPedido.length;
  }

  @override
  String toString() {
    String res = '';
    for (ItemPedido i in itensPedido) {
      res += '${i.toString()}\n';
    }
    return res;
  }
}
