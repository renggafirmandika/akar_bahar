import 'package:flutter/material.dart';
import 'package:flutter_exercise/models/wilayah_model.dart';
import 'package:flutter_exercise/tabs/wilayahDetail.dart';
import 'package:flutter_exercise/utils/database_helper.dart';
import 'dart:core';

List<WilayahModel> wilayah_list = [];
List<WilayahModel> wilayah_list_filtered = [];
TextEditingController teSearch = TextEditingController();

class Wilayah extends StatefulWidget {
  const Wilayah({super.key});

  @override
  State<Wilayah> createState() => _WilayahState();
}

class _WilayahState extends State<Wilayah> {
  int count = 10;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    _runFilter(_controller.text);
  }

  void initState() {
    super.initState();
    getData();
    _controller.addListener(_printLatestValue);
  }

  void getData() async {
    var dbHelper = DatabaseHelper();
    List<WilayahModel> _wilayah_list = await dbHelper.getWilayah();
    setState(() {
      wilayah_list = _wilayah_list;
      wilayah_list_filtered = wilayah_list;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<WilayahModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = wilayah_list;
    } else {
      results = wilayah_list
          .where((kom) =>
              kom.namaWilayah
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              kom.kodeWilayah.contains(enteredKeyword.toLowerCase()) ||
              kom.displayKode.contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      wilayah_list_filtered = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Wilayah Administrasi'),
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
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              //onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                hintText: 'Cari Nama atau Kode Wilayah',
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: _controller.clear,
                        icon: Icon(Icons.clear),
                        splashColor: Colors.transparent,
                      )
                    : null,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Flexible(child: getWilayahListView()),
        ],
      ),
    );
  }

  ListView getWilayahListView() {
    //TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.separated(
      padding: const EdgeInsets.all(0.0),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: wilayah_list_filtered.length,
      itemBuilder: (BuildContext context, int position) {
        final index = position;
        if (wilayah_list_filtered[index].jenisWilayah != "DESA/KELURAHAN")
          return ListTile(
            dense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0.0, vertical: -4.0),
            leading: Chip(
              label: Text(wilayah_list_filtered[index].displayKode),
              labelStyle: TextStyle(color: Colors.white, fontSize: 12.0),
              backgroundColor: Colors.green,
              elevation: 1,
            ),
            title: Transform.translate(
              offset: Offset(0, -6),
              child: Text(wilayah_list_filtered[index].namaWilayah),
            ),
            subtitle: Transform.translate(
              offset: Offset(0, -6),
              child: Text(wilayah_list_filtered[index].jenisWilayah),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WilayahDetail(
                          wilayah_list_filtered[index].id,
                          wilayah_list_filtered[index].kdProv,
                          wilayah_list_filtered[index].prov,
                          wilayah_list_filtered[index].kdKab,
                          wilayah_list_filtered[index].kab,
                          wilayah_list_filtered[index].kdKec,
                          wilayah_list_filtered[index].kec,
                          wilayah_list_filtered[index].kodeWilayah,
                          wilayah_list_filtered[index].namaWilayah,
                          wilayah_list_filtered[index].jenisWilayah,
                          wilayah_list_filtered[index].kodeLevelAtas,
                          wilayah_list_filtered[index].klasifikasi,
                          wilayah_list_filtered[index].displayKode)));
            },
          );
        else
          return ListTile(
            dense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0.0, vertical: -4.0),
            leading: Chip(
              label: Text(wilayah_list_filtered[index].displayKode),
              labelStyle: TextStyle(color: Colors.white, fontSize: 12.0),
              backgroundColor: Colors.green,
              elevation: 1,
            ),
            title: Transform.translate(
              offset: Offset(0, 0),
              child: Text(wilayah_list_filtered[index].namaWilayah),
            ),
            subtitle: Transform.translate(
              offset: Offset(0, 0),
              child: wilayah_list_filtered[index].klasifikasi == 1
                  ? Text(wilayah_list_filtered[index].jenisWilayah +
                      '\n1 - Perkotaan')
                  : Text(wilayah_list_filtered[index].jenisWilayah +
                      '\n2 - Perdesaan'),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WilayahDetail(
                          wilayah_list_filtered[index].id,
                          wilayah_list_filtered[index].kdProv,
                          wilayah_list_filtered[index].prov,
                          wilayah_list_filtered[index].kdKab,
                          wilayah_list_filtered[index].kab,
                          wilayah_list_filtered[index].kdKec,
                          wilayah_list_filtered[index].kec,
                          wilayah_list_filtered[index].kodeWilayah,
                          wilayah_list_filtered[index].namaWilayah,
                          wilayah_list_filtered[index].jenisWilayah,
                          wilayah_list_filtered[index].kodeLevelAtas,
                          wilayah_list_filtered[index].klasifikasi,
                          wilayah_list_filtered[index].displayKode)));
            },
          );
      },
    );
  }
}
