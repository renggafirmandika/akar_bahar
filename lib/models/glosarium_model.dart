class GlosariumModel {
  int _id;
  String _rincian;
  String _istilah;
  String _kondef;
  String _kategori;
  String _blok;
  String _caption;

  GlosariumModel(
    this._id,
    this._rincian,
    this._istilah,
    this._kondef,
    this._kategori,
    this._blok,
    this._caption,
  );

  int get id => _id;

  String get rincian => _rincian;
  String get istilah => _istilah;
  String get kondef => _kondef;
  String get kategori => _kategori;
  String get blok => _blok;
  String get caption => _caption;
}
