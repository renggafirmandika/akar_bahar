import 'package:flutter/material.dart';
import 'package:flutter_exercise/models/satuanproduksi_model.dart';
import 'package:flutter_exercise/utils/database_helper.dart';
import 'dart:core';

List<SatuanProduksiModel> satuanProduksi_list = [];
List<SatuanProduksiModel> satuanProduksi_list_filtered = [];
TextEditingController teSearch = TextEditingController();

class SatuanProduksi extends StatefulWidget {
  const SatuanProduksi({super.key});

  @override
  State<SatuanProduksi> createState() => _SatuanProduksiState();
}

class _SatuanProduksiState extends State<SatuanProduksi> {
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
    List<SatuanProduksiModel> _satuanProduksi_list =
        await dbHelper.getSatuanProduksi();
    setState(() {
      satuanProduksi_list = _satuanProduksi_list;
      satuanProduksi_list_filtered = satuanProduksi_list;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<SatuanProduksiModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = satuanProduksi_list;
    } else {
      results = satuanProduksi_list
          .where((kom) =>
              kom.satuanProduksi
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              kom.kodesatuanProduksi == enteredKeyword)
          .toList();
    }

    setState(() {
      satuanProduksi_list_filtered = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kode Satuan Produksi'),
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
          /*
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Cari satuan produksi',
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          */
          Flexible(child: getSatuanProduksiListView()),
        ],
      ),
    );
  }

  ListView getSatuanProduksiListView() {
    //TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: satuanProduksi_list_filtered.length,
      itemBuilder: (BuildContext context, int position) {
        final index = position;
        final kodesatuan =
            satuanProduksi_list_filtered[index].kodesatuanProduksi.toString();

        return ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: satuanProduksi_list_filtered[index].satuanProduksi +
                        '\n',
                    style: TextStyle(
                        fontSize: 17,
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
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                  TextSpan(
                    text: ' Kode ST2023: 0' + kodesatuan,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700]),
                  ),
                ],
              ),
            ),
          ),

          /*
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JenisProduksiDetail(
                        satuanProduksi_list_filtered[index].id,
                        satuanProduksi_list_filtered[index].kodeKomoditas,
                        satuanProduksi_list_filtered[index].namaKomoditas,
                        satuanProduksi_list_filtered[index].ket1,
                        satuanProduksi_list_filtered[index].ket2,
                        satuanProduksi_list_filtered[index].ket3,
                        satuanProduksi_list_filtered[index].nama_lokal)));
          },
          */
        );
      },
    );
  }
}
