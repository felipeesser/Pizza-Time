import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pizza_time/modelo/pedido.dart';

const pathPedidos = '/restaurante/unico/pedidos';

/// Armazena no banco de dados um novo documento com o [pedido] fornecido.
///
/// O [pedido] fornecido será armazenado na coleção de pedidos do restaurante.
///
/// ```dart
/// ...
/// await create(novoPedido);
/// ...
/// ```
void create(Pedido pedido) async {
  DocumentReference novoDocumento = Firestore.instance
      .collection(pathPedidos)
      .document();
  pedido.idPedido = novoDocumento.documentID;
  await novoDocumento.setData(pedido.toMap(), merge: false);
}

/// Lê o [documento] e retorna um pedido com os dados lidos.
///
/// Retorna null se o documento não existir.
///
/// ```dart
/// ...
/// Item aux = await read(refEmpresaUsuario);
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
  DocumentReference documento = Firestore.instance
      .collection(pathPedidos)
      .document(pedido.idPedido);
  await documento.updateData(pedido.toMap());
}

/// Remove do firestore o [pedido] armazenado na coleção de pedidos do restaurante.
///
/// ```dart
/// ...
/// await delete(pedido);
/// ...
/// ```
Future<void> delete(Pedido pedido) async {
  DocumentReference documento = Firestore.instance
      .collection(pathPedidos)
      .document(pedido.idPedido);
  await documento.delete();
}
