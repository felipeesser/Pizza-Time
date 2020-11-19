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
  return snapshot == null ? null : Usuario.fromMap(snapshot.data);
}
