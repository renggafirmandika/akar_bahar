import 'package:flutter/material.dart';
import 'package:flutter_exercise/models/wilayah_model.dart';
import 'package:flutter_exercise/tabs/wilayahkabs.dart';
import 'package:flutter_exercise/utils/database_helper.dart';
import 'dart:core';

List<WilayahModel> WilayahProv_list = [];
List<WilayahModel> WilayahProv_list_filtered = [];
List<WilayahModel> WilayahAll_list = [];
List<WilayahModel> WilayahAll_list_filtered = [];
TextEditingController teSearch = TextEditingController();

class WilayahProv extends StatefulWidget {
  const WilayahProv({super.key});

  @override
  State<WilayahProv> createState() => _WilayahProvState();
}

class _WilayahProvState extends State<WilayahProv> {
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
    List<WilayahModel> _WilayahProv_list = await dbHelper.getProv();
    List<WilayahModel> _WilayahAll_list = await dbHelper.getWilayah();
    setState(() {
      WilayahProv_list = _WilayahProv_list;
      WilayahProv_list_filtered = WilayahProv_list;
      WilayahAll_list = _WilayahAll_list;
      WilayahAll_list_filtered = _WilayahAll_list;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<WilayahModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = WilayahProv_list;
    } else {
      results = WilayahProv_list.where((kom) =>
          kom.namaWilayah
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()) ||
          kom.kodeWilayah.contains(enteredKeyword.toLowerCase()) ||
          kom.displayKode.contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      WilayahProv_list_filtered = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Wilayah Provinsi'),
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
              controller: _controller,
              //onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                hintText: 'Cari Nama atau Kode Provinsi',
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
          Flexible(child: getWilayahProvListView()),
        ],
      ),
    );
  }

  ListView getWilayahProvListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: WilayahProv_list_filtered.length,
      itemBuilder: (BuildContext context, int position) {
        final index = position;
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          visualDensity: VisualDensity(horizontal: 0.0, vertical: -4.0),
          leading: Chip(
            label: Text(WilayahProv_list_filtered[index].displayKode),
            labelStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.green,
            elevation: 1,
          ),
          title: Transform.translate(
            offset: Offset(0, -6),
            child: Text(WilayahProv_list_filtered[index].namaWilayah),
          ),
          subtitle: Transform.translate(
            offset: Offset(0, -6),
            child: Text(WilayahProv_list_filtered[index].jenisWilayah),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.grey,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WilayahKabs(
                        WilayahProv_list_filtered[index].id,
                        WilayahProv_list_filtered[index].kdProv,
                        WilayahProv_list_filtered[index].prov,
                        WilayahProv_list_filtered[index].kdKab,
                        WilayahProv_list_filtered[index].kab,
                        WilayahProv_list_filtered[index].kdKec,
                        WilayahProv_list_filtered[index].kec,
                        WilayahProv_list_filtered[index].kodeWilayah,
                        WilayahProv_list_filtered[index].namaWilayah,
                        WilayahProv_list_filtered[index].jenisWilayah,
                        WilayahProv_list_filtered[index].kodeLevelAtas,
                        WilayahProv_list_filtered[index].klasifikasi,
                        WilayahProv_list_filtered[index].displayKode)));
          },
        );
      },
    );
  }
}
