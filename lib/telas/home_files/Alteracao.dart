import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_time/modelo/Usuario.dart';
import 'package:pizza_time/telas/revisar_pedido/components/tab_detalhes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza_time/api/usuario_firestore.dart' as fireBaseUsuarioCrud;

const pathUsuarios = '/usuarios';

class Alteracao extends StatefulWidget {
  static final nomeTela = "/alteracao";
  @override
  _AlteracaoState createState() => _AlteracaoState();
}

class _AlteracaoState extends State<Alteracao> {
  Future<bool> acesso;
  Usuario _usuarioAtual;
  String senhaAntiga;
  String emailAntigo;
  @override
  void initState() {
    acesso = getUser();
    super.initState();
  }

  Future<bool> getUser() async {
    var id = (await FirebaseAuth.instance.currentUser()).uid;
    DocumentReference documento =
        Firestore.instance.collection(pathUsuarios).document(id);
    _usuarioAtual = await fireBaseUsuarioCrud.read(documento);
    emailAntigo = _usuarioAtual.email;
    return _usuarioAtual != null ? true : false;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _salvarUsuario(context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    fireBaseUsuarioCrud.update(_usuarioAtual);
    (await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAntigo, password: senhaAntiga));
    (await FirebaseAuth.instance.currentUser())
      ..updatePassword(_usuarioAtual.senha)
      ..updateEmail(_usuarioAtual.email);
    // print(_usuarioAtual.nome);
    // print(_usuarioAtual.idUsuario);
    // print(_usuarioAtual.email);
    // print(_usuarioAtual.telefone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Alteração de Cadastro'),
        ),
        body: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(204, 41, 0, 1)),
          padding: EdgeInsets.all(16),
          child: FutureBuilder(
              future: acesso,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                // controller: _controllerNome,
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(32, 16, 32, 16),
                                    hintText: _usuarioAtual.nome,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32))),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Nome nao preenchido";
                                  }
                                  ;
                                  return null;
                                },
                                onSaved: (String value) {
                                  _usuarioAtual.nome = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                // controller: _controllerEmail,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(32, 16, 32, 16),
                                    hintText: _usuarioAtual.email,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32))),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Email nao preenchido";
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _usuarioAtual.email = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                //controller: _controllerSenha,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(32, 16, 32, 16),
                                    hintText: "Digite a senha Antiga",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32))),
                                validator: (String value) {
                                  if (value.isEmpty && value.length <= 6) {
                                    return "Senha nao preenchida ou menor do que 6 digitos";
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  senhaAntiga = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                //controller: _controllerSenha,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(32, 16, 32, 16),
                                    hintText: "Senha",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32))),
                                validator: (String value) {
                                  if (value.isEmpty && value.length <= 6) {
                                    return "Senha nao preenchida ou menor do que 6 digitos";
                                  }
                                  ;
                                  return null;
                                },
                                onSaved: (String value) {
                                  _usuarioAtual.senha = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: TextFormField(
                                //controller: _controllerTelefone,
                                obscureText: true,
                                keyboardType: TextInputType.numberWithOptions(),
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(32, 16, 32, 16),
                                    hintText: _usuarioAtual.telefone,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32))),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Telefone nao preenchido";
                                  }
                                  ;
                                  return null;
                                },
                                onSaved: (String value) {
                                  _usuarioAtual.telefone = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16, bottom: 10),
                              child: RaisedButton(
                                  child: Text(
                                    "Atualizar",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    _salvarUsuario(_usuarioAtual);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Text("Carregando...");
                }
              }),
        ));
  }
}
