class JasaModel {
  int _id;
  String _namaJasa;
  String _kodeJasa;
  String _deskrpsi;

  JasaModel(
    this._id,
    this._namaJasa,
    this._kodeJasa,
    this._deskrpsi,
  );

  int get id => _id;

  String get namaJasa => _namaJasa;
  String get kodeJasa => _kodeJasa;
  String get deskrpsi => _deskrpsi;
}
