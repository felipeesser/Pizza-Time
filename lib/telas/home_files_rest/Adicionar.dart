import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizza_time/api/item_firebase.dart';
import 'package:pizza_time/modelo/Item.dart';
class Adicionar extends StatefulWidget {
  @override
  _AdicionarState createState() => _AdicionarState();
}

class _AdicionarState extends State<Adicionar> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  Item _itematual=Item();
  PickedFile _imageFile=null;
  _buscarImagenLocal()async{
    PickedFile imagefile=await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
    );
    if (imagefile!=null){
      setState(() {
        _imageFile=imagefile;
      });
    }
  }
  _salvarItem(context){
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    if(_imageFile==null){
      procura(_itematual,imagem: null);
    }
    else {
      procura(_itematual,imagem:File(_imageFile.path));
    }
    print(_itematual.nome);
    print(_itematual.tipo);
    print(_itematual.preco);
    print(_itematual.descricao);
  }
  @override
  Widget build(BuildContext context) {
    AlertDialog alert=AlertDialog(
        title: Text('item adicionado'),
        actions: [FlatButton(
          child: Text('ok'),
          onPressed: (){Navigator.of(context).pop();},
        )]
    );
    return Container(
      padding: EdgeInsets.all(16),
      child:Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (_imageFile==null)?Text('Adicionar foto:',style: TextStyle(fontSize: 20),):null,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (_imageFile==null)?FlatButton(
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side:BorderSide(
                            width: 3,
                            color: Theme.of(context).primaryColor
                        ),
                      ),
                        child: Icon(Icons.add_a_photo,size: 60,color: Theme.of(context).primaryColor,),
                        onPressed: (){_buscarImagenLocal();}
                        ):Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Image.file(
                            File(_imageFile.path),
                            fit: BoxFit.cover,
                            height: 200,
                        ),
                        FlatButton(
                            onPressed: (){_buscarImagenLocal();},
                            shape: RoundedRectangleBorder(
                            ),
                            color: Colors.black26,
                            child: Text('trocar imagem',style: TextStyle(color: Colors.white),)
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Adicionar campos:',style: TextStyle(fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Nome",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32))),
                      validator: (String value){
                        if(value.isEmpty){
                          return "Nome nao preenchido";
                        };
                        return null;
                      },
                      onSaved: (String value){
                        _itematual.nome=value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Tipo",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32))),
                      validator: (String value){
                        if(value.isEmpty){
                          return "Tipo nao preenchido";
                        };
                        return null;
                      },
                      onSaved: (String value){
                        _itematual.tipo=value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Preço",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32))),
                      validator: (String value){
                        if(value.isEmpty){
                          return "Preco nao preenchido";
                        };
                        return null;
                      },
                      onSaved: (String value){
                        _itematual.preco=value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Descrição",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32))),
                      validator: (String value){
                        if(value.isEmpty){
                          return "Descricao nao preenchido";
                        };
                        return null;
                      },
                      onSaved: (String value){
                        _itematual.descricao=value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                      ),
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                        onPressed: (){
                        _salvarItem(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return alert;
                            },
                        );
                        },
                        child: Text("Enviar",style: TextStyle(color: Theme.of(context).accentColor),),
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
