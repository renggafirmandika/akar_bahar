class WilayahModel {
  int _id;
  String _kdprov;
  String _prov;
  String _kdkab;
  String _kab;
  String _kdkec;
  String _kec;
  String _kodeWilayah;
  String _namaWilayah;
  String _jenisWilayah;
  String _kodeLevelAtas;
  int _klasifikasi;
  String _displayKode;

  WilayahModel(
    this._id,
    this._kdprov,
    this._prov,
    this._kdkab,
    this._kab,
    this._kdkec,
    this._kec,
    this._kodeWilayah,
    this._namaWilayah,
    this._jenisWilayah,
    this._kodeLevelAtas,
    this._klasifikasi,
    this._displayKode,
  );

  int get id => _id;

  String get kdProv => _kdprov;
  String get prov => _prov;
  String get kdKab => _kdkab;
  String get kab => _kab;
  String get kdKec => _kdkec;
  String get kec => _kec;

  String get kodeWilayah => _kodeWilayah;

  String get namaWilayah => _namaWilayah;

  String get jenisWilayah => _jenisWilayah;

  String get kodeLevelAtas => _kodeLevelAtas;

  int get klasifikasi => _klasifikasi;

  String get displayKode => _displayKode;
}
