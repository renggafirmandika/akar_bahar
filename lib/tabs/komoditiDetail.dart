import 'dart:async';
import 'dart:io' as io;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

//import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class KomoditiDetail extends StatefulWidget {
  final int id;
  final String name, kat, ket1a, ket1b, ket2a, ket2b, ket3a, ket3b, nama_lokal;

  KomoditiDetail(this.id, this.name, this.kat, this.ket1a, this.ket1b,
      this.ket2a, this.ket2b, this.ket3a, this.ket3b, this.nama_lokal);

  @override
  State<KomoditiDetail> createState() => _KomoditiDetailState();
}

class _KomoditiDetailState extends State<KomoditiDetail> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    // final topContent = Stack(
    //   children: <Widget>[
    //     Container(
    //         padding: EdgeInsets.only(left: 10.0),
    //         height: MediaQuery.of(context).size.height * 0.5,
    //         decoration: new BoxDecoration(
    //           image: new DecorationImage(
    //             image: new AssetImage("assets/placeholder.jpg"),
    //             fit: BoxFit.cover,
    //           ),
    //         )),
    //     Container(
    //         padding: EdgeInsets.only(left: 10.0),
    //         height: MediaQuery.of(context).size.height * 0.5,
    //         decoration: new BoxDecoration(
    //           image: new DecorationImage(
    //             image:
    //                 new AssetImage("assets/" + widget.id.toString() + ".jpg"),
    //             fit: BoxFit.cover,
    //           ),
    //         )),
    //   ],
    // );
    //final FirebaseStorageService storage = FirebaseStorageService();

    //_komoditiController = Get.find();

    //var itemCount = _komoditiController.allKomoditiImages.length;

    final double width = MediaQuery.of(context).size.width * 0.9;

    final List<String> imgList = ['${widget.id}_1.jpg', '${widget.id}_2.jpg'];

    Future<io.File> _getLocalFile(String filename) async {
      String dir = (await getApplicationDocumentsDirectory()).path;
      io.File f = new io.File('$dir/$filename');
      return f;
    }

    // _checkLocalFile(String filename) async {
    //   String dir = (await getApplicationDocumentsDirectory()).path;
    //   io.File f = new io.File('$dir/$filename');

    //   if (await f.exists()) {
    //     imgList2.add(filename);
    //   }
    // }

    // for (var i = 0; i < imgList.length; i++) {
    //   _checkLocalFile(imgList[i]);
    // }

    final List<Widget> imageSliders = imgList
        .map(
          (item) => FutureBuilder(
              future: _getLocalFile(item),
              builder: (context, snapshot) {
                return Container(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          InstaImageViewer(
                            child: Center(
                              child: Image.file(
                                snapshot.data!,
                                fit: BoxFit.contain,
                                height: width,
                                errorBuilder: ((context, error, stackTrace) {
                                  return Container(
                                    child:
                                        Image.asset('assets/placeholder.jpg'),
                                  );
                                }),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
        .toList();

    final topContent = CarouselSlider(
      items: imageSliders,
      options: CarouselOptions(
          viewportFraction: 0.9,
          height: width,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );

    final topContent2 = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );

    final bottomContentText0 = new ListTile(
      title: Text(
        widget.kat,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    final bottomContentText1 = new ListTile(
      title: Text("Nama Komoditas (Kode):"),
      subtitle: Text(widget.name),
    );

    final bottomContentText2 = new ListTile(
      title: Text(widget.ket1a + ": "),
      subtitle: Text(widget.ket1b.trim()),
    );

    final bottomContentText3 = new ListTile(
      title: Text(widget.ket2a + ": "),
      subtitle: Text(widget.ket2b.trim()),
    );

    final bottomContentText4 = new ListTile(
      title: Text(widget.ket3a + ": "),
      subtitle: Text(widget.ket3b.trim()),
    );

    final bottomContentText5 = new ListTile(
      title: Text("Nama Lokal:"),
      subtitle: Text(widget.nama_lokal.trim()),
    );

    final bottomContent = Expanded(
      child: SingleChildScrollView(
          child: Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Center(
          child: Column(
            children: <Widget>[
              bottomContentText0,
              bottomContentText1,
              if (widget.ket1a != '') bottomContentText2,
              if (widget.ket2a != '') bottomContentText3,
              if (widget.ket3a != '') bottomContentText4,
              bottomContentText5
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
          topContent,
          topContent2,
          const Divider(
            height: 20,
            color: Colors.green,
            thickness: 4,
            indent: 20,
            endIndent: 20,
          ),
          bottomContent
        ],
      ),
    );
  }
}
