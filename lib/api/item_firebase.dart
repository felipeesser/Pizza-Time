import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:uuid/uuid.dart';

import 'package:pizza_time/modelo/Item.dart';

const pathCardapio = '/restaurante/unico/cardapio';

/// Armazena no banco de dados um novo documento com o [item] fornecido.
///
/// Incorpora ao item, como url, a [imagem] fornecida.
///
/// ```dart
/// ...
/// await create(macarrao);
/// ...
/// ```
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

/// Armazena a [imagem] no storage do firestore e retorna a url de download.
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

/// Lê o [documento] e retorna um item com os dados lidos.
///
/// ```dart
/// ...
/// Item aux = await read(refPizza);
/// ...
/// ```
Future<Item> read(DocumentReference documento) async {
  final snapshot = await documento?.get();
  return snapshot.data == null ? null : Item.fromMap(snapshot.data);
}

/// Atualiza o [item] no firestore, com o valor atual do item.
///
/// ```dart
/// ...
/// await update(novoHamburger);
/// ...
/// ```
void update(Item item) async {
  DocumentReference documento =
      Firestore.instance.collection(pathCardapio).document(item.idItem);
  await documento.updateData(item.toMap());
}

/// Remove o [item] do firestore.
///
/// ```dart
/// ...
/// await delete(pizzaDoce);
/// ...
/// ```
void delete(Item item) async {
  DocumentReference documento =
      Firestore.instance.collection(pathCardapio).document(item.idItem);
  await documento.delete();
}
void procura(Item item,{File imagem}) async {//procura se existe item com msm nome
  bool achou=false;
  String urlDownloadImagem;
  final snapshot = await Firestore.instance.collection(pathCardapio).getDocuments();
  if (imagem != null) {
    urlDownloadImagem = await _salvaImagem(imagem);
  }
  snapshot.documents.forEach((element) {
    if (element.data['nome']==item.nome){
      item.idItem=element.documentID;
      item.imagem=urlDownloadImagem;
      update(item);
      achou=true;
    }
  });
  if(!achou) create(item,imagem: imagem);
}
//coloca no notifier os itens do cardapio
getItens(ItemNotifier itemNotifier)async{
  QuerySnapshot snapshot=await Firestore.instance.collection(pathCardapio).getDocuments();
  List<Item> _itemList=[];
  snapshot.documents.forEach((document){
    Item item=Item.fromMap(document.data);
    _itemList.add(item);
  });
  itemNotifier.listaItens=_itemList;
}

/// Retorna a coleção cardápio do restaurante.
///
///```dart
/// CollectionReference cardapio = colecaoCardapio(uuidUsuario);
///```
CollectionReference colecaoCardapio(String idUsuario) {
  return Firestore.instance.collection(pathCardapio);
}
