class KomoditiModel {
  int _id;
  String _subjudulKomoditas;
  String _judulKomoditas;
  String _ket1a;
  String _ket1b;
  String _ket2a;
  String _ket2b;
  String _ket3a;
  String _ket3b;
  String _nama_lokal;

  KomoditiModel(
      this._id,
      this._subjudulKomoditas,
      this._judulKomoditas,
      this._ket1a,
      this._ket1b,
      this._ket2a,
      this._ket2b,
      this._ket3a,
      this._ket3b,
      this._nama_lokal);

  int get id => _id;

  String get subjudulKomoditas => _subjudulKomoditas;

  String get judulKomoditas => _judulKomoditas;

  String get ket1a => _ket1a;

  String get ket1b => _ket1b;

  String get ket2a => _ket2a;

  String get ket2b => _ket2b;

  String get ket3a => _ket3a;

  String get ket3b => _ket3b;

  String get nama_lokal => _nama_lokal;
}
