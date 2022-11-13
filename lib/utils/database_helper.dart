import 'package:flutter/services.dart';
import 'package:flutter_exercise/models/wilayah_prov.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter_exercise/models/komoditi_model.dart';
import 'package:flutter_exercise/models/wilayah_model.dart';
import 'package:flutter_exercise/models/glosarium_model.dart';
import 'package:flutter_exercise/models/jasa_model.dart';
import 'package:flutter_exercise/models/wpp_model.dart';
import 'package:flutter_exercise/models/jenisproduksi_model.dart';
import 'package:flutter_exercise/models/satuanproduksi_model.dart';

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
          list[i]['1a'] == null ? '' : list[i]['1a'],
          list[i]['1b'] == null ? '' : list[i]['1b'],
          list[i]['2a'] == null ? '' : list[i]['2a'],
          list[i]['2b'] == null ? '' : list[i]['2b'],
          list[i]['3a'] == null ? '' : list[i]['3a'],
          list[i]['3b'] == null ? '' : list[i]['3b'],
          list[i]['nama_lokal'] == null ? '' : list[i]['nama_lokal']));
    }
    return komoditas;
  }

  Future<List<WilayahModel>> getWilayah() async {
    var dbClient = await db;
    List<Map> list = await dbClient!
        .rawQuery('SELECT * FROM kode_wilayah ORDER BY kode_wilayah asc');
    List<WilayahModel> wilayah = [];
    for (int i = 0; i < list.length; i++) {
      wilayah.add(new WilayahModel(
          list[i]['id_wilayah'],
          list[i]['kdprov'],
          list[i]['prov'],
          list[i]['kdkab'],
          list[i]['kab'],
          list[i]['kdkec'],
          list[i]['kec'],
          list[i]['kode_wilayah'],
          list[i]['nama_wilayah'],
          list[i]['jenis_wilayah'],
          list[i]['kode_level_atas'],
          list[i]['klasifikasi'],
          list[i]['display_kode']));
    }
    return wilayah;
  }

  Future<List<WilayahProvModel>> getWilayahProv() async {
    var dbClient = await db;

    List<Map> list = await dbClient!.rawQuery(
        'SELECT * FROM kode_wilayah WHERE kode_level_atas="00" ORDER BY kode_wilayah asc');
    List<WilayahProvModel> wilayah = [];
    for (int i = 0; i < list.length; i++) {
      wilayah.add(new WilayahProvModel(
        list[i]['kdprov'],
        list[i]['prov'].toString().toTitleCase(),
      ));
    }
    return wilayah;
  }

  Future<List<WilayahModel>> getWilayahKabs(prop) async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery(
        'SELECT * FROM kode_wilayah WHERE kdprov = ' +
            prop +
            ' ORDER BY kode_wilayah asc');
    List<WilayahModel> wilayah = [];
    for (int i = 0; i < list.length; i++) {
      wilayah.add(new WilayahModel(
          list[i]['id_wilayah'],
          list[i]['kdprov'],
          list[i]['prov'],
          list[i]['kdkab'],
          list[i]['kab'],
          list[i]['kdkec'],
          list[i]['kec'],
          list[i]['kode_wilayah'],
          list[i]['nama_wilayah'],
          list[i]['jenis_wilayah'],
          list[i]['kode_level_atas'],
          list[i]['klasifikasi'],
          list[i]['display_kode']));
    }
    return wilayah;
  }

  Future<List<WilayahModel>> getProv() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery(
        'SELECT * FROM kode_wilayah WHERE jenis_wilayah = "PROVINSI" ORDER BY kode_wilayah asc');
    List<WilayahModel> wilayah = [];
    for (int i = 0; i < list.length; i++) {
      wilayah.add(new WilayahModel(
          list[i]['id_wilayah'],
          list[i]['kdprov'],
          list[i]['prov'],
          list[i]['kdkab'],
          list[i]['kab'],
          list[i]['kdkec'],
          list[i]['kec'],
          list[i]['kode_wilayah'],
          list[i]['nama_wilayah'],
          list[i]['jenis_wilayah'],
          list[i]['kode_level_atas'],
          list[i]['klasifikasi'],
          list[i]['display_kode']));
    }
    return wilayah;
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

  Future<List<JasaModel>> getJasa() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient!.rawQuery('SELECT * FROM kode_jasa ORDER BY kode_jasa');
    List<JasaModel> jasa = [];
    for (int i = 0; i < list.length; i++) {
      jasa.add(new JasaModel(
        list[i]['id_jasa'],
        list[i]['nama_jasa'],
        list[i]['kode_jasa'],
        list[i]['deskripsi'],
      ));
    }
    return jasa;
  }

  Future<List<JenisProduksiModel>> getJenisProduksi() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient!.rawQuery('SELECT * FROM kode_jenisproduksi');
    List<JenisProduksiModel> jenisproduksi = [];
    for (int i = 0; i < list.length; i++) {
      jenisproduksi.add(new JenisProduksiModel(
        list[i]['id_jenis_produksi'],
        list[i]['jenis_produksi'],
        list[i]['kode_jenis_produksi'],
        list[i]['jenis'],
      ));
    }
    return jenisproduksi;
  }

  Future<List<SatuanProduksiModel>> getSatuanProduksi() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient!.rawQuery('SELECT * FROM kode_satuanproduksi');
    List<SatuanProduksiModel> satuanproduksi = [];
    for (int i = 0; i < list.length; i++) {
      satuanproduksi.add(new SatuanProduksiModel(
        list[i]['id_satuan_produksi'],
        list[i]['satuan_produksi'],
        list[i]['kode_satuan_produksi'],
      ));
    }
    return satuanproduksi;
  }

  Future<List<WppModel>> getWpp() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM kode_wpp');
    List<WppModel> wpp = [];
    for (int i = 0; i < list.length; i++) {
      wpp.add(new WppModel(
        list[i]['id_wpp'],
        list[i]['kode_wpp'],
        list[i]['deskripsi'],
        list[i]['jenis_wilayah'],
      ));
    }
    return wpp;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}
