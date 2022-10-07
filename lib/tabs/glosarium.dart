import 'package:flutter/material.dart';
import 'package:flutter_exercise/models/glosarium_model.dart';
import 'package:flutter_exercise/utils/database_helper.dart';
import 'dart:core';

List<GlosariumModel> glosarium_list = [];
List<GlosariumModel> glosarium_list_filtered = [];
TextEditingController teSearch = TextEditingController();

class Glosarium extends StatefulWidget {
  const Glosarium({super.key});

  @override
  State<Glosarium> createState() => _GlosariumState();
}

class _GlosariumState extends State<Glosarium> {
  int count = 10;

  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var dbHelper = DatabaseHelper();
    List<GlosariumModel> _glosarium_list = await dbHelper.getGlosarium();
    setState(() {
      glosarium_list = _glosarium_list;
      glosarium_list_filtered = glosarium_list;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<GlosariumModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = glosarium_list;
    } else {
      results = glosarium_list
          .where((kom) =>
              kom.istilah.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      glosarium_list_filtered = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glosarium'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Cari istilah', suffixIcon: Icon(Icons.search)),
            ),
          ),
          Flexible(child: getGlosariumListView()),
        ],
      ),
    );
  }

  ListView getGlosariumListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: glosarium_list_filtered.length,
      itemBuilder: (BuildContext context, int position) {
        final index = position;
        return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                glosarium_list_filtered[index].istilah,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Container(
              child: (Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      glosarium_list_filtered[index].kondef,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  if (glosarium_list_filtered[index].blok != "" &&
                      glosarium_list_filtered[index].rincian != "")
                    Text(
                      'Blok ' +
                          glosarium_list_filtered[index].blok +
                          ' rincian ' +
                          glosarium_list_filtered[index].rincian +
                          '',
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                      textAlign: TextAlign.justify,
                    )
                ],
              )),
            )

            /*
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GlosariumDetail(
                        glosarium_list_filtered[index].id,
                        glosarium_list_filtered[index].kodeKomoditas,
                        glosarium_list_filtered[index].namaKomoditas,
                        glosarium_list_filtered[index].ket1,
                        glosarium_list_filtered[index].ket2,
                        glosarium_list_filtered[index].ket3,
                        glosarium_list_filtered[index].nama_lokal)));
          },
          */
            );
      },
    );
  }
}
