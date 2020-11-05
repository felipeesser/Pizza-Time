import 'package:flutter/material.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest_Ped.dart';
class Home_Rest extends StatefulWidget {
  @override
  _Home_RestState createState() => _Home_RestState();
}

class _Home_RestState extends State<Home_Rest> {
   List<Widget> _widgetOptions = <Widget>[
    ListView(
      children: <Widget>[
        Home_Rest_Ped("Alberto","cartao","Rua dos bobos 666",["pizza doce","pizza de carne seca"],["1","2"]),
        Home_Rest_Ped("Roberto","dinheiro","Rua dos bobos 6666",["pizza doce","pizza de carne seca"],["2","2"]),
        Home_Rest_Ped("Marreco","cartao","Rua dos bobos 66666",["pizza doce","pizza de carne seca"],["1","3"]),
      ],
    ),
    Text("Pagina Chat"),
    Text("Pagina Config"),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status:'),
                Container(
                    padding: EdgeInsets.all(5),
                    child: Text('Fechado',style: TextStyle(color: Colors.red),),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
              ],
            ),
            actions: [
              IconButton(icon:Icon(Icons.calendar_today), onPressed:(){})
            ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Config',
            ),
          ],
          selectedItemColor: Theme.of(context).iconTheme.color,
          onTap:_onItemTapped,
        ),
    );
  }
}
