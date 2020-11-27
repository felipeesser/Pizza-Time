// ignore: slash_for_doc_comments
/**
EXEMPLO DE USO

```dart
import '.../pedido_firebase.dart' as pedidoFirebaseCrud;
import '.../pedido.dart';
...
var pedido = Pedido(
  statusPedido: 'Na fila',
  pagamento: 'Dinheiro',
  valor: '21.00',
  idEndereco: 'algumIdEndereco',
  idUsuario: 'algumUuidUsuario',
);
// CREATE
pedidoFirebaseCrud.create(pedido);
print(pedido.toMap());

// READ
var documento = Firestore.instance.document(
  '${pedidoFirebaseCrud.pathPedidosRestaurante}/${pedido.idPedido}'
);
var lidoCriado = await pedidoFirebaseCrud.read(documento);
print(lidoCriado.toMap());

// UPDATE
pedidoFirebaseCrud.update(
  pedido
    ..statusPedido = 'Preparando'
);

// READ
var lidoAtualizado = await pedidoFirebaseCrud.read(documento);
print(lidoAtualizado.toMap());

// DELETE
pedidoFirebaseCrud.delete(pedido);

// READ
var lidoDeletado = await pedidoFirebaseCrud.read(documento);
print('${lidoDeletado?.toMap()==null ? 'Não existe um pedido no documento fornecido.': lidoDeletado.toMap()}');
```
*/
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pizza_time/api/item_firebase.dart' as itemFirebaseCrud;
import 'package:pizza_time/modelo/Item.dart';
import 'package:pizza_time/modelo/carrinho.dart';
import 'package:pizza_time/modelo/item_carrinho.dart';
import 'package:pizza_time/modelo/pedido.dart';

const pathPedidosRestaurante = '/restaurante/unico/pedidos';
const _pathPedidosUsuario = '/usuarios/$_replaceToken/pedidos';
const _replaceToken = '-replaceToken';

/// Armazena no Firebase um novo documento com o [pedido] fornecido.
///
/// O [pedido] fornecido será armazenado na coleção de pedidos do restaurante.
///
/// ```dart
/// ...
/// await create(novoPedido);
/// ...
/// ```
void create(Pedido pedido) async {
  DocumentReference novoDocumentoRestaurante =
      Firestore.instance.collection(pathPedidosRestaurante).document();
  pedido.idPedido = novoDocumentoRestaurante.documentID;
  await novoDocumentoRestaurante.setData(pedido.toMap(), merge: false);
  // manter essa ordem
  DocumentReference novoDocumentoUsuario =
      _colecaoPedidosUsuario(pedido.idUsuario).document(pedido.idPedido);
  await novoDocumentoUsuario.setData(pedido.toMap(), merge: false);
}

/// Lê o [documento] e retorna um pedido com os dados lidos.
///
/// Retorna null se o documento não existir.
///
/// ```dart
/// ...
/// Pedido aux = await read(refPedidoUsuario);
/// ...
/// ```
Future<Pedido> read(DocumentReference documento) async {
  final snapshot = await documento?.get();
  return snapshot.data == null ? null : Pedido.fromMap(snapshot.data);
}

/// Atualiza o [pedido] no firestore, com o valor atual do [pedido].
///
/// ```dart
/// ...
/// await update(pedido);
/// ...
/// ```
void update(Pedido pedido) async {
  DocumentReference documentoRestaurante = Firestore.instance
      .collection(pathPedidosRestaurante)
      .document(pedido.idPedido);
  DocumentReference documentoUsuario = _documentoPedidoUsuario(
      idPedido: pedido.idPedido, idUsuario: pedido.idUsuario);
  await documentoRestaurante.updateData(pedido.toMap());
  await documentoUsuario.updateData(pedido.toMap());
}

/// Remove do firestore o [pedido] armazenado na coleção de pedidos do restaurante.
///
/// ```dart
/// ...
/// await delete(pedido);
/// ...
/// ```
void delete(Pedido pedido) async {
  DocumentReference documentoRestaurante = Firestore.instance
      .collection(pathPedidosRestaurante)
      .document(pedido.idPedido);
  DocumentReference documentoUsuario = _documentoPedidoUsuario(
      idPedido: pedido.idPedido, idUsuario: pedido.idUsuario);
  await documentoRestaurante.delete();
  await documentoUsuario.delete();
}

// =============================================================================

/// Retorna a lista de todos os [Pedido] do restaurante.
Future<List<Pedido>> pedidosFromRestaurante() async {
  List<Pedido> pedidos = [];
  final snapshots = await Firestore.instance
      .collection(pathPedidosRestaurante)
      .getDocuments();
  final documentos = snapshots.documents;
  for (DocumentSnapshot doc in documentos) {
    Pedido pedido = Pedido.fromMap(doc.data);
    pedidos.add(pedido);
  }
  return pedidos;
}

/// Retorna uma lista de [Pedido] que pertencem ao usuario com [idUsuario].
Future<List<Pedido>> pedidosFromUsuario(String idUsuario) async {
  List<Pedido> pedidos = [];
  final snapshots = await _colecaoPedidosUsuario(idUsuario).getDocuments();
  final documentos = snapshots.documents;
  for (DocumentSnapshot doc in documentos) {
    Pedido pedido = Pedido.fromMap(doc.data);
    pedidos.add(pedido);
  }
  return pedidos;
}

/// Retorna um [Carrinho] a partir do [Pedido] fornecido.
Future<Carrinho> carrinhoFromPedido(Pedido pedido) async {
  final carrinho = Carrinho();
  CollectionReference cardapio =
      Firestore.instance.collection(itemFirebaseCrud.pathCardapio);
  for (MapEntry<String, int> idItemQuantidade
      in pedido.idsItemQuantidade.entries) {
    Item item =
        await itemFirebaseCrud.read(cardapio.document(idItemQuantidade.key));
    // pode não estar mais lá
    if (item != null) {
      carrinho.itensCarrinho
          .add(ItemCarrinho(item: item, quantidade: idItemQuantidade.value));
    }
  }
  return carrinho;
}

/// Retorna a colecao de pedidos do usuario com [idUsuario].
///
///```dart
/// String path = colecaoPedidosUsuario(uuidUsuario);
///```
CollectionReference _colecaoPedidosUsuario(String idUsuario) {
  return Firestore.instance.collection(
    _pathPedidosUsuario.replaceAll(_replaceToken, idUsuario),
  );
}

/// Retorna o documento onde o [idPedido] de um dado [idusuario] está armazenado.
///
///```dart
/// DocumentReference documento = _documentoPedidoUsuario(
///   idUsuario: uuidUsuario,
///   idPedido: uuidPedidoHamburguer
/// );
///```
DocumentReference _documentoPedidoUsuario({String idUsuario, String idPedido}) {
  return Firestore.instance.document(
      '${_pathPedidosUsuario.replaceAll(_replaceToken, idUsuario)}/$idPedido');
}
