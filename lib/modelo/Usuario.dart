class Usuario {
  String _idUsuario;
  String _nome;
  String _email;
  String _telefone;
  // REVIEW - precisa da senha armazenada?
  String _senha;
  List<String> idsEnderecos;
  // String _endereco;
  // String _numero;
  // String _complemento;

  Usuario();

//TODO MODIFICAR O USUARIO PARA ACEITAR MAIS DE UM ENDEREÇO

  Usuario.fromMap(Map<String, dynamic> data) {
    idUsuario = data['idUsuario'];
    nome = data['nome'];
    email = data['email'];
    telefone = data['telefone'];
    // null caso caso a chave não exista ou o valor da chave seja null em dados;
    if (data['idsEnderecos'].runtimeType == null) {
      idsEnderecos = null;
    } else {
      // resolve o retorno do banco de dados que não vem List, mas é um iteravel.
      idsEnderecos = List<String>.from(data['idsEnderecos']);
    }
    // endereco = data['endereço'];
    // numero = data['numero'];
    // complemento = data['complemento'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idUsuario': idUsuario,
      "nome": this.nome,
      "email": this.email,
      "telefone": this.telefone,
      'idsEnderecos': idsEnderecos,
      // "endereco": this.endereco,
      // "numero": this.numero,
      // "complemento": this.complemento,
    };
    return map;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  // String get complemento => _complemento;

  // set complemento(String value) {
  //   _complemento = value;
  // }

  // String get endereco => _endereco;

  // set endereco(String value) {
  //   _endereco = value;
  // }

  // String get numero => _numero;

  // set numero(String value) {
  //   _numero = value;
  // }
}
