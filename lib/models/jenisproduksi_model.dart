class JenisProduksiModel {
  int _id;
  String _jenisProduksi;
  String _kodeJenisProduksi;
  String _jenis;

  JenisProduksiModel(
    this._id,
    this._jenisProduksi,
    this._kodeJenisProduksi,
    this._jenis,
  );

  int get id => _id;

  String get jenisProduksi => _jenisProduksi;
  String get kodeJenisProduksi => _kodeJenisProduksi;
  String get jenis => _jenis;
}
