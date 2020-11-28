class Usuario {
  String _idUsuario;
  String _nome;
  String _email;
  String _telefone;
  // REVIEW - precisa da senha armazenada?
  String _senha;

  Usuario();

  Usuario.fromMap(Map<String, dynamic> data) {
    idUsuario = data['idUsuario'];
    nome = data['nome'];
    email = data['email'];
    telefone = data['telefone'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idUsuario': idUsuario,
      "nome": this.nome,
      "email": this.email,
      "telefone": this.telefone,
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
}
