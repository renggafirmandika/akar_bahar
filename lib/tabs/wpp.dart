import 'package:flutter/material.dart';
import 'package:flutter_exercise/models/wpp_model.dart';
import 'package:flutter_exercise/utils/database_helper.dart';
import 'dart:core';

List<WppModel> wpp_list = [];
List<WppModel> wpp_list_filtered = [];
TextEditingController teSearch = TextEditingController();

class Wpp extends StatefulWidget {
  const Wpp({super.key});

  @override
  State<Wpp> createState() => _WppState();
}

class _WppState extends State<Wpp> {
  int count = 10;

  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var dbHelper = DatabaseHelper();
    List<WppModel> _wpp_list = await dbHelper.getWpp();
    setState(() {
      wpp_list = _wpp_list;
      wpp_list_filtered = wpp_list;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<WppModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = wpp_list;
    } else {
      results = wpp_list
          .where((kom) =>
              kom.kodeWpp
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              kom.deskripsi
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              kom.jenisWilayah
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      wpp_list_filtered = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kode WPP'),
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
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Cari wilayah perairan',
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          Flexible(child: getWppListView()),
        ],
      ),
    );
  }

  ListView getWppListView() {
    //TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: wpp_list_filtered.length,
      itemBuilder: (BuildContext context, int position) {
        final index = position;
        return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                wpp_list_filtered[index].kodeWpp,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Container(
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      wpp_list_filtered[index].deskripsi,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Text(
                    wpp_list_filtered[index].jenisWilayah,
                    style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                    textAlign: TextAlign.left,
                  )
                ],
              )),
            )

            /*
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WppDetail(
                        wpp_list_filtered[index].id,
                        wpp_list_filtered[index].kodeKomoditas,
                        wpp_list_filtered[index].namaKomoditas,
                        wpp_list_filtered[index].ket1,
                        wpp_list_filtered[index].ket2,
                        wpp_list_filtered[index].ket3,
                        wpp_list_filtered[index].nama_lokal)));
          },
          */
            );
      },
    );
  }
}
