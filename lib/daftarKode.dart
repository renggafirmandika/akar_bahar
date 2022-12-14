import 'package:flutter/material.dart';
//import 'package:flutter_exercise/tabs/second_tab.dart';
import 'package:flutter_exercise/tabs/jasa.dart';
import 'package:flutter_exercise/tabs/jenisproduksi.dart';
import 'package:flutter_exercise/tabs/satuanproduksi.dart';
import 'package:flutter_exercise/tabs/wilayahprov.dart';
import 'package:flutter_exercise/tabs/wpp.dart';
//import 'package:flutter_exercise/tabs/wilayahprov.dart';

// ignore: must_be_immutable
class DaftarKode extends StatelessWidget {
  List<Mycard> mycard = [
    Mycard(Icons.location_on_outlined, 'Kode Wilayah', false, WilayahProv()),
    Mycard(Icons.water, 'Kode WPP', false, Wpp()),
    Mycard(Icons.work_outline_outlined, 'Kode Jasa', false, Jasa()),
    Mycard(
        Icons.forest_outlined, 'Kode\nJenis Produksi', false, JenisProduksi()),
    Mycard(Icons.monitor_weight_outlined, 'Kode\nSatuan Produksi', false,
        SatuanProduksi()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Daftar Kode'),
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green.shade800, Colors.green.shade600])),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/pattern.png',
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
            child: Text(
              'Pilih Daftar Kode',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child: Column(
                //crossAxisCount: 1,
                //crossAxisSpacing: 8,
                //mainAxisSpacing: 8,
                children: mycard
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => e.menu),
                          );
                        },
                        child: Card(
                          color: e.isActive ? Colors.green : null,
                          elevation: 2,
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Positioned(
                                top: -70,
                                left: -90,
                                child: Icon(
                                  e.icon,
                                  size: 150,
                                  color: Colors.green.shade50,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    e.title,
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                  leading: Icon(
                                    e.icon,
                                    size: 40,
                                    color: e.isActive
                                        ? Colors.white
                                        : Colors.green[700],
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: Colors.green[700],
                                  ),
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // children: <Widget>[
                                  // Icon(
                                  //   e.icon,
                                  //   size: 50,
                                  //   color: e.isActive
                                  //       ? Colors.white
                                  //       : Colors.green[700],
                                  // ),
                                  // SizedBox(height: 10),
                                  // Text(
                                  //   e.title,
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //       color: e.isActive
                                  //           ? Colors.white
                                  //           : Colors.grey),
                                  // ),
                                  //],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;
  final menu;

  Mycard(this.icon, this.title, this.isActive, this.menu);
}
