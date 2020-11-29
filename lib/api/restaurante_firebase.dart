import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_time/modelo/Restaurante.dart';

const pathRestaurante = '/restaurante/unico';

void create(Restaurante restaurante) async {
  DocumentReference novoDocumento;
  novoDocumento = Firestore.instance.document(pathRestaurante);
  //Firestore.instance.collection(pathRestaurante).document('unico');
  await novoDocumento.setData(restaurante.toMap(), merge: false);
}

Future<Restaurante> read() async {
  final snapshot = await Firestore.instance.document(pathRestaurante).get();
  return snapshot.data == null ? null : Restaurante.fromMap(snapshot.data);
}

Future<bool> procuraDono() async {
  final snapshot = await Firestore.instance.document(pathRestaurante).get();
  if (snapshot.data['idDono'] == null) {
    return true;
  } else {
    return false;
  }
}

Future<String> idDono() async {
  final snapshot = await Firestore.instance.document(pathRestaurante).get();
  if (snapshot.data['idDono'] != null) {
    return snapshot.data['idDono'];
  } else {
    return '';
  }
}

void update(Restaurante restaurante) async {
  DocumentReference documento = Firestore.instance.document(pathRestaurante);
  await documento.updateData(restaurante.toMap());
}
