import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_time/api/usuario_firestore.dart';
import 'package:pizza_time/modelo/Restaurante.dart';
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/telas/Login.dart';
import 'package:pizza_time/api/restaurante_firebase.dart'
    as RestauranteFirestoreCrud;
import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirestoreCrud;

//import 'Home.dart';
import 'package:pizza_time/modelo/Usuario.dart';

class Cadastro extends StatefulWidget {
  static final nomeTela = "/cadastro";
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Controladores
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerEndereco = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerComplemento = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    //Recupera dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    String endereco = _controllerEndereco.text;
    String numero = _controllerNumero.text;
    String complemento = _controllerComplemento.text;
    String telefone = _controllerTelefone.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 6) {
          if (endereco.isNotEmpty) {
            if (numero.isNotEmpty) {
              if (complemento.isNotEmpty) {
                if (telefone.isNotEmpty) {
                  setState(() {
                    _mensagemErro = "";
                  });
                  Usuario usuario = Usuario();
                  usuario.nome = nome;
                  usuario.email = email;
                  usuario.senha = senha;
                  final novoEndereco = Endereco(
                      rua: endereco, numero: numero, complemento: complemento);
                  // TODO - usuario não tem esses campos.
                  // usuario.endereco = endereco;
                  // usuario.numero = numero;
                  // usuario.complemento = complemento;
                  usuario.telefone = telefone;
                  _cadastrarUsuario(usuario, novoEndereco);
                } else {
                  setState(() {
                    _mensagemErro = "Preencha o Telefone";
                  });
                }
              } else {
                setState(() {
                  _mensagemErro = "Preencha o complemento";
                });
              }
            } else {
              setState(() {
                _mensagemErro = "Preencha o número";
              });
            }
          } else {
            setState(() {
              _mensagemErro = "Preencha o endereço";
            });
          }
        } else {
          setState(() {
            _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha o E-mail utilizando @";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o Nome";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario, Endereco endereco) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) async {
      //Salvar dados do usuário
      usuario.idUsuario = firebaseUser.user.uid;
      create(usuario);
      enderecoFirestoreCrud.create(
          endereco: endereco, idUsuario: usuario.idUsuario);
      var rest = await RestauranteFirestoreCrud.read();
      bool existeDono = false;
      Restaurante restaurante = await RestauranteFirestoreCrud.read();
      if (restaurante == null) {
        restaurante = Restaurante.fromMap(
          {
            'aberto': false,
          },
        );
        RestauranteFirestoreCrud.create(restaurante);
      }
      if (usuario.nome == 'dono' &&
          (await RestauranteFirestoreCrud.procuraDono())) {
        //TODO ADICIONAR MAP FUNCIONAMENTO
        restaurante.idDono = usuario.idUsuario;
        restaurante.telefone = usuario.telefone;
        RestauranteFirestoreCrud.update(restaurante);
      }
      // db
      //     .collection("usuarios")
      //     .document(firebaseUser.user.uid) //.additionalUserInfo.providerId
      //     .setData(usuario.toMap());

      Navigator.pushReplacementNamed(context, "/login");
    }).catchError((error) {
      print("erro app: " + error.toString());
      setState(() {
        _mensagemErro =
            "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Cadastro",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(204, 41, 0, 1)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerSenha,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEndereco,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Endereço",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _controllerNumero,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Nr",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32))),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: TextField(
                          controller: _controllerComplemento,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(32, 16, 32, 16),
                              hintText: "Complemento",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32))),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: TextField(
                    controller: _controllerTelefone,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Telefone",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        _validarCampos();
                        Navigator.of(context).pop();
                      }),
                ),
                Center(
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
