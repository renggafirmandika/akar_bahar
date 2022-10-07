import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter_exercise/models/komoditi_model.dart';
import 'package:flutter_exercise/models/glosarium_model.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "komoditas.db");
    bool dbExist = await io.File(path).exists();
    if (!dbExist) {
      ByteData data = await rootBundle.load(join("assets", "komoditas.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await io.File(path).writeAsBytes(bytes, flush: true);
    }

    var theDb = await openDatabase(path, version: 1);
    return theDb;
  }

  Future<List<KomoditiModel>> getKomoditas() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM Komoditas');
    List<KomoditiModel> komoditas = [];
    for (int i = 0; i < list.length; i++) {
      komoditas.add(new KomoditiModel(
          list[i]['kode'],
          list[i]['subjudul'],
          list[i]['judul'],
          list[i]['1a'],
          list[i]['1b'],
          list[i]['2a'],
          list[i]['2b'],
          list[i]['3a'],
          list[i]['3b'],
          list[i]['nama_lokal']));
    }
    return komoditas;
  }

  Future<List<GlosariumModel>> getGlosarium() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM glosarium ');
    List<GlosariumModel> glosarium = [];
    for (int i = 0; i < list.length; i++) {
      glosarium.add(new GlosariumModel(
        list[i]['id_glosarium'],
        list[i]['rincian'],
        list[i]['istilah'],
        list[i]['kondef'],
        list[i]['kategori'],
        list[i]['blok'],
        list[i]['caption'],
      ));
    }
    return glosarium;
  }
}
