import 'package:flutter/material.dart';
import 'package:flutter_exercise/models/jasa_model.dart';
import 'package:flutter_exercise/utils/database_helper.dart';
import 'dart:core';

List<JasaModel> jasa_list = [];
List<JasaModel> jasa_list_filtered = [];
TextEditingController teSearch = TextEditingController();

class Jasa extends StatefulWidget {
  const Jasa({super.key});

  @override
  State<Jasa> createState() => _JasaState();
}

class _JasaState extends State<Jasa> {
  int count = 10;

  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var dbHelper = DatabaseHelper();
    List<JasaModel> _jasa_list = await dbHelper.getJasa();
    setState(() {
      jasa_list = _jasa_list;
      jasa_list_filtered = jasa_list;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<JasaModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = jasa_list;
    } else {
      results = jasa_list
          .where((kom) =>
              kom.namaJasa
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              kom.kodeJasa
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              kom.deskrpsi.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      jasa_list_filtered = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jasa'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Cari jasa', suffixIcon: Icon(Icons.search)),
            ),
          ),
          Flexible(child: getJasaListView()),
        ],
      ),
    );
  }

  ListView getJasaListView() {
    //TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: jasa_list_filtered.length,
      itemBuilder: (BuildContext context, int position) {
        final index = position;
        return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: jasa_list_filtered[index].namaJasa + '\n',
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
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ),
                    TextSpan(
                      text: ' Kode ST2023: ' +
                          jasa_list_filtered[index].kodeJasa +
                          '',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700]),
                    ),
                  ],
                ),
              ),
            ),
            subtitle: Container(
              child: (Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      jasa_list_filtered[index].deskrpsi,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
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
                    builder: (context) => jasaDetail(
                        jasa_list_filtered[index].id,
                        jasa_list_filtered[index].kodeKomoditas,
                        jasa_list_filtered[index].namaKomoditas,
                        jasa_list_filtered[index].ket1,
                        jasa_list_filtered[index].ket2,
                        jasa_list_filtered[index].ket3,
                        jasa_list_filtered[index].nama_lokal)));
          },
          */
            );
      },
    );
  }
}
