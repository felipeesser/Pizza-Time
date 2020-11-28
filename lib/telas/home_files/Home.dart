import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:provider/provider.dart';
import 'home_files_components/HomeDrawer.dart';
import 'home_files_components/HomeFilter.dart';
import 'home_files_components/HomeItens.dart';
import 'home_files_components/HomeBottom.dart';
import 'home_files_components/HomeSearchBar.dart';
import 'package:pizza_time/api/item_firebase.dart';

class Home extends StatefulWidget {
  static final nomeTela = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    ItemNotifier itemNotifier =
        Provider.of<ItemNotifier>(context, listen: false);
    getItens(itemNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context);
    return GestureDetector(
      onTap: () => {FocusScope.of(context).unfocus()},
      child: Scaffold(
        drawer: Drawer(child: HomeDrawer()),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(204, 41, 0, 1)),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(204, 41, 0, 1),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 6, right: 2, top: 6),
                            child: HomeSearchBar())),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 2, right: 6, top: 6),
                            child: HomeFilter())),
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: HomeItens(itemNotifier),
              ),
              Expanded(
                flex: 1,
                child: HomeBottom(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// This trailing comma makes auto-formatting nicer for build methods
