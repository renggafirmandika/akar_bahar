import 'package:flutter/material.dart';
import 'package:flutter_exercise/models/jenisproduksi_model.dart';
import 'package:flutter_exercise/utils/database_helper.dart';
import 'dart:core';

List<JenisProduksiModel> jenisProduksi_list = [];
List<JenisProduksiModel> jenisProduksi_list_filtered = [];
TextEditingController teSearch = TextEditingController();

class JenisProduksi extends StatefulWidget {
  const JenisProduksi({super.key});

  @override
  State<JenisProduksi> createState() => _JenisProduksiState();
}

class _JenisProduksiState extends State<JenisProduksi> {
  int count = 10;

  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var dbHelper = DatabaseHelper();
    List<JenisProduksiModel> _jenisProduksi_list =
        await dbHelper.getJenisProduksi();
    setState(() {
      jenisProduksi_list = _jenisProduksi_list;
      jenisProduksi_list_filtered = jenisProduksi_list;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<JenisProduksiModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = jenisProduksi_list;
    } else {
      results = jenisProduksi_list
          .where((kom) =>
              kom.jenisProduksi
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              kom.jenis.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              kom.kodeJenisProduksi
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      jenisProduksi_list_filtered = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kode Jenis Produksi'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Cari jenis produksi',
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          Flexible(child: getJenisProduksiListView()),
        ],
      ),
    );
  }

  ListView getJenisProduksiListView() {
    //TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: jenisProduksi_list_filtered.length,
      itemBuilder: (BuildContext context, int position) {
        final index = position;
        int jumlahchar =
            jenisProduksi_list_filtered[index].kodeJenisProduksi.length;
        String kodejenis = '';
        if (jumlahchar == 1)
          kodejenis =
              '0' + jenisProduksi_list_filtered[index].kodeJenisProduksi;
        else
          kodejenis = jenisProduksi_list_filtered[index].kodeJenisProduksi;
        return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: jenisProduksi_list_filtered[index].jenisProduksi +
                          '\n',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          '',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.arrow_circle_right_sharp,
                        color: Colors.pink,
                        size: 13.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ),
                    TextSpan(
                      text: ' Kode ST2023: ' + kodejenis + '',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700]),
                    ),
                  ],
                ),
              ),
            ),
            subtitle: Container(
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      jenisProduksi_list_filtered[index].jenis,
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              )),
            )

            /*
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JenisProduksiDetail(
                        jenisProduksi_list_filtered[index].id,
                        jenisProduksi_list_filtered[index].kodeKomoditas,
                        jenisProduksi_list_filtered[index].namaKomoditas,
                        jenisProduksi_list_filtered[index].ket1,
                        jenisProduksi_list_filtered[index].ket2,
                        jenisProduksi_list_filtered[index].ket3,
                        jenisProduksi_list_filtered[index].nama_lokal)));
          },
          */
            );
      },
    );
  }
}
