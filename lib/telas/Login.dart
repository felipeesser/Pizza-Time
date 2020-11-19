import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/Restaurante.dart';
import 'package:pizza_time/modelo/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza_time/telas/home_files/Home.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest.dart';
import 'Cadastro.dart';
import 'package:pizza_time/api/restaurante_firebase.dart'
    as RestauranteFirebaseCrud;

class Login extends StatefulWidget {
  static final nomeTela = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty) {
        setState(() {
          _mensagemErro = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail utilizando @";
      });
    }
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) async {
      Restaurante rest = await RestauranteFirebaseCrud.read();
      if (firebaseUser.user.uid != await RestauranteFirebaseCrud.idDono()) {
        Navigator.pushReplacementNamed(context, Home.nomeTela);
      } else {
        Navigator.pushReplacementNamed(context, Home_Rest.nomeTela);
      }
    }).catchError((error) {
      setState(() {
        _mensagemErro =
            "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
      });
    });
  }

  /*Future _verificarUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    //auth.signOut();

    FirebaseUser usuarioLogado = await auth.currentUser();

    if( usuarioLogado != null ){
      Navigator.pushReplacementNamed(context, "/home");
    }

  }

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(204, 41, 0, 1),
      body: Column(children: <Widget>[
        Flexible(
          child: Image.asset(
            "Imagens/logo2.png",
          ),
        ),
        Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: _controllerEmail,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "E-mail",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: _controllerSenha,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Senha",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FlatButton(
                          child: Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: Color.fromRGBO(204, 41, 0, 1),
                          onPressed: () {
                            _validarCampos();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FlatButton(
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed(Cadastro.nomeTela);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.white,
            )),
      ]),
    );
  }
}
