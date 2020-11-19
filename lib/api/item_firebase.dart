import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import 'package:pizza_time/modelo/Item.dart';

const pathCardapio = '/restaurante/unico/cardapio';

/// Armazena no banco de dados um novo documento com o [item] fornecido.
///
/// O novo documento será criado na coleção padrão do [item], a saber,
/// '/restaurante/unico/cardapio'.
void create(Item item, {File imagem}) async {
  String urlDownloadImagem;
  // salva a imagem se imagem != null
  if (imagem != null) {
    urlDownloadImagem = await _salvaImagem(imagem);
  }
  DocumentReference novoDocumento =
      Firestore.instance.collection(pathCardapio).document();
  item.idItem = novoDocumento.documentID;
  item.imagem = urlDownloadImagem;
  await novoDocumento.setData(item.toMap(), merge: false);
}

Future<String> _salvaImagem(File imagem) async {
  final uuid = Uuid().v4();
  final extensao = path.extension(imagem.path);
  String urlDownload;
  final StorageReference localArmazenamento =
      FirebaseStorage.instance.ref().child('$pathCardapio/$uuid$extensao');
  await localArmazenamento.putFile(imagem).onComplete.catchError(
    (onError) {
      print(onError);
      return false;
    },
  );
  urlDownload = await localArmazenamento.getDownloadURL();
  return urlDownload;
}

Future<Item> read(DocumentReference documento) async {
  final snapshot = await documento?.get();
  return snapshot == null ? null : Item.fromMap(snapshot?.data);
}

void update(Item item) async {
  DocumentReference documento =
      Firestore.instance.collection(pathCardapio).document(item.idItem);
  await documento.updateData(item.toMap());
}

void delete(Item item) async {
  DocumentReference documento =
      Firestore.instance.collection(pathCardapio).document(item.idItem);
  await documento.delete();
}
