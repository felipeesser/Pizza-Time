import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Cadastro.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  @override
  double _altideal(BuildContext context){
    var hbase=MediaQuery.of(context).size.height * .1;
    var hdispon=MediaQuery.of(context).size.height-(MediaQuery.of(context).viewInsets.bottom+hbase);
    var hideal=MediaQuery.of(context).size.height * .5;
    var result=hideal>hdispon? hdispon:hideal;
    return result;
  }
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos(){

    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if( email.isNotEmpty && email.contains("@") ){

      if( senha.isNotEmpty ){

        setState(() {
          _mensagemErro = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario( usuario );


      }else{
        setState(() {
          _mensagemErro = "Preencha a senha!";
        });
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o E-mail utilizando @";
      });
    }

  }

  _logarUsuario( Usuario usuario ){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      Navigator.pushReplacementNamed(context, "/home");

    }).catchError((error){

      setState(() {
        _mensagemErro = "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
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
      body: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                "Imagens/logo2.png",
                scale: .8,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .1),
              child: Container(
                height: _altideal(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.only(bottom: 23),
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
                      TextField(
                        controller: _controllerSenha,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "Senha",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 23, bottom: 10),
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
                      Center(
                          child: FlatButton(
                              child: Text(
                                "Cadastre-se",
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              color: Colors.white,
                              onPressed: () {Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cadastro()
                                  )
                              );
                              })
                      ),
                    ]
                ),
              ),
            ),
          ]
      ),
    );
  }
}
