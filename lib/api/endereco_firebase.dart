import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pizza_time/modelo/Usuario.dart';
import 'package:pizza_time/modelo/endereco.dart';

const replaceToken = 'replaceToken';
const pathEnderecos = '/usuarios/$replaceToken/enderecos';

/// Armazena no banco de dados um novo documento com o [endereco] fornecido.
///
/// O [endereço] fornecido será armazenado na coleção de endereços do [usuario].
///
/// ```dart
/// ...
/// await create(casa, usuario);
/// ...
/// ```
void create({Endereco endereco, Usuario usuario}) async {
  DocumentReference novoDocumento = Firestore.instance
      .collection(pathEnderecos.replaceAll(replaceToken, usuario.idUsuario))
      .document();
  endereco.idEndereco = novoDocumento.documentID;
  await novoDocumento.setData(endereco.toMap(), merge: false);
}

/// Lê o [documento] e retorna um enereco com os dados lidos.
///
/// ```dart
/// ...
/// Item aux = await read(refEmpresaUsuario);
/// ...
/// ```
Future<Endereco> read(DocumentReference documento) async {
  final snapshot = await documento?.get();
  return snapshot == null ? null : Endereco.fromMap(snapshot.data);
}

/// Atualiza o [endereco] no firestore, com o valor atual do [endereco].
///
/// ```dart
/// ...
/// await update(enderecoCasaVeraneio);
/// ...
/// ```
void update(Endereco endereco, Usuario usuario) async {
  DocumentReference documento = Firestore.instance
      .collection(pathEnderecos.replaceAll(replaceToken, usuario.idUsuario))
      .document(endereco.idEndereco);
  await documento.updateData(endereco.toMap());
}

/// Remove do firestore o [enedreco] armazenado na coleção de endereços do [usuario].
///
/// ```dart
/// ...
/// await delete(casaEx, usuario);
/// ...
/// ```
void delete(Endereco endereco, Usuario usuario) async {
  DocumentReference documento = Firestore.instance
      .collection(pathEnderecos.replaceAll(replaceToken, usuario.idUsuario))
      .document(endereco.idEndereco);
  await documento.delete();
}
