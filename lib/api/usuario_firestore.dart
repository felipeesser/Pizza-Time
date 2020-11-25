import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pizza_time/modelo/Usuario.dart';

const pathUsuarios = '/usuarios';

void create(Usuario usuario) async {
  DocumentReference novoDocumento;
  novoDocumento =
      Firestore.instance.collection(pathUsuarios).document(usuario.idUsuario);
  await novoDocumento.setData(usuario.toMap(), merge: false);
}

Future<Usuario> read(DocumentReference documento) async {
  final snapshot = await documento?.get();
  return snapshot.data == null ? null : Usuario.fromMap(snapshot.data);
}

/// Atualiza o [usuario] no firestore, com o valor atual do [usuario].
///
/// ```dart
/// ...
/// await update(usuario);
/// ...
/// ```
void updade(Usuario usuario) async {
  if (usuario == null) {
    return;
  }
  DocumentReference documento =
      Firestore.instance.collection(pathUsuarios).document(usuario.idUsuario);
  await documento.updateData(usuario.toMap());
}

/// Remove um usuario com [idUsuario] da coleção de usuarios.
///
/// Essa função não remove o cadastro do usuario da autenticação no FirestoreAuth.
///
/// ```dart
/// ...
/// await delete(usuario.idUsuario);
/// ...
/// ```
Future<void> delete(String idUsuario) async {
  DocumentReference documento =
      Firestore.instance.collection(pathUsuarios).document(idUsuario);
  documento.delete();
}

DocumentReference documentoUsuario(String idUsuario) {
  return Firestore.instance.document('$pathUsuarios/$idUsuario');
}