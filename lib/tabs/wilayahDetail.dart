import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/1102.jpg',
  'assets/placeholder.jpg',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        // decoration: BoxDecoration(
                        //   gradient: LinearGradient(
                        //     colors: [
                        //       Color.fromARGB(200, 0, 0, 0),
                        //       Color.fromARGB(0, 0, 0, 0)
                        //     ],
                        //     begin: Alignment.bottomCenter,
                        //     end: Alignment.topCenter,
                        //   ),
                        // ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        // child: Text(
                        //   'No. ${imgList.indexOf(item)} image',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 20.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class WilayahDetail extends StatefulWidget {
  int id, klasifikasi;
  String kdprov,
      prov,
      kdkab,
      kab,
      kdkec,
      kec,
      kode_wilayah,
      nama_wilayah,
      jenis_wilayah,
      kode_level_atas,
      display_kode;

  WilayahDetail(
      this.id,
      this.kdprov,
      this.prov,
      this.kdkab,
      this.kab,
      this.kdkec,
      this.kec,
      this.kode_wilayah,
      this.nama_wilayah,
      this.jenis_wilayah,
      this.kode_level_atas,
      this.klasifikasi,
      this.display_kode);

  @override
  State<WilayahDetail> createState() => _WilayahDetailState();
}

class _WilayahDetailState extends State<WilayahDetail> {
  //int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final bottomContentText0 = new ListTile(
      leading: Chip(
        label: Text(widget.display_kode),
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.green,
        elevation: 1,
      ),
      title: Text(
        widget.nama_wilayah,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: widget.klasifikasi == 1
          ? Text(widget.jenis_wilayah + '\n1 - Perkotaan')
          : Text(widget.jenis_wilayah + '\n2 - Perdesaan'),
    );

    final CardDetailWilayah = new Card(
      color: Colors.white,
      elevation: 1.0,
      //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: SizedBox(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
              //padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (widget.jenis_wilayah == "PROVINSI" ||
                      widget.jenis_wilayah == "KOTA" ||
                      widget.jenis_wilayah == "KABUPATEN" ||
                      widget.jenis_wilayah == "KECAMATAN" ||
                      widget.jenis_wilayah == "DESA/KELURAHAN")
                    ListTile(
                      leading: Chip(
                        label: Text(widget.kdprov),
                        labelStyle: TextStyle(color: Colors.green[700]),
                        backgroundColor: Colors.green[100],
                        elevation: 1,
                      ),
                      title: Text(
                        widget.prov,
                      ),
                      subtitle: Text('Provinsi'),
                    ),
                  if (widget.jenis_wilayah == "KOTA" ||
                      widget.jenis_wilayah == "KABUPATEN" ||
                      widget.jenis_wilayah == "KECAMATAN" ||
                      widget.jenis_wilayah == "DESA/KELURAHAN")
                    ListTile(
                      leading: Chip(
                        label: Text(widget.kdkab),
                        labelStyle: TextStyle(color: Colors.green[700]),
                        backgroundColor: Colors.green[100],
                        elevation: 1,
                      ),
                      title: Text(
                        widget.kab,
                      ),
                      subtitle: Text('Kabupaten/Kota'),
                    ),
                  if (widget.jenis_wilayah == "KECAMATAN" ||
                      widget.jenis_wilayah == "DESA/KELURAHAN")
                    ListTile(
                      leading: Chip(
                        label: Text(widget.kdkec),
                        labelStyle: TextStyle(color: Colors.green[700]),
                        backgroundColor: Colors.green[100],
                        elevation: 1,
                      ),
                      title: Text(
                        widget.kec,
                      ),
                      subtitle: Text('Kecamatan'),
                    ),
                  if (widget.jenis_wilayah == "DESA/KELURAHAN")
                    ListTile(
                      leading: Chip(
                        label: Text(widget.kode_wilayah),
                        labelStyle: TextStyle(color: Colors.green[700]),
                        backgroundColor: Colors.green[100],
                        elevation: 1,
                      ),
                      title: Text(
                        widget.nama_wilayah,
                      ),
                      subtitle: widget.klasifikasi == 1
                          ? Text('Desa/Kelurahan \n1 - Perkotaan')
                          : Text('Desa/Kelurahan \n2 - Perdesaan'),
                    ),
                ],
              ))
        ],
      )),
    );

    final bottomContentText1 = new ListTile(
      title: Text("Nama Wilayah:"),
      subtitle: Text(widget.nama_wilayah),
    );

    final bottomContentText2 = new ListTile(
      title: Text("Jenis Wilayah:"),
      subtitle: Text(widget.jenis_wilayah),
    );

    final bottomContent = Expanded(
      child: SingleChildScrollView(
          child: Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              bottomContentText0,
              CardDetailWilayah,
              //  bottomContentText2,
            ],
          ),
        ),
      )),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Detail'),
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green.shade800, Colors.green.shade600])),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/pattern.png',
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          bottomContent,
        ],
      ),
    );
  }
}
