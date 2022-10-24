class WppModel {
  int _id;
  String _kodeWpp;
  String _deskripsi;
  String _jenisWilayah;

  WppModel(
    this._id,
    this._kodeWpp,
    this._deskripsi,
    this._jenisWilayah,
  );

  int get id => _id;

  String get kodeWpp => _kodeWpp;
  String get deskripsi => _deskripsi;
  String get jenisWilayah => _jenisWilayah;
}
