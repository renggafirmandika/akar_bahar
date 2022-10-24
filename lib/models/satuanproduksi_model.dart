class SatuanProduksiModel {
  int _id;
  String _satuanProduksi;
  int _kodesatuanProduksi;

  SatuanProduksiModel(
    this._id,
    this._satuanProduksi,
    this._kodesatuanProduksi,
  );

  int get id => _id;

  String get satuanProduksi => _satuanProduksi;
  int get kodesatuanProduksi => _kodesatuanProduksi;
}
