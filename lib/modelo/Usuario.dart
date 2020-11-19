class Usuario {
  String _idUsuario;
  String _nome;
  String _email;
  String _senha;
  String _endereco;
  String _numero;
  String _complemento;
  String _telefone;
  Usuario();

//TODO MODIFICAR O USUARIO PARA ACEITAR MAIS DE UM ENDEREÇO  

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "endereco": this.endereco,
      "numero": this.numero,
      "complemento": this.complemento,
      "telefone": this.telefone
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

  String get complemento => _complemento;

  set complemento(String value) {
    _complemento = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  Usuario.fromMap(Map<String, dynamic> data) {
    nome = data['nome'];
    email = data['email'];
    endereco = data['endereço'];
    numero = data['numero'];
    complemento = data['complemento'];
    telefone = data['telefone'];
    idUsuario = data['idUsuario'];
  }
}
