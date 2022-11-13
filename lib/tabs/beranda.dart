import 'package:flutter/material.dart';
import 'package:flutter_exercise/bulletList.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class Beranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
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
      body: new SingleChildScrollView(
        child: Column(
          children: [
            // logo ST
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                Container(
                  child: Image.asset(
                    'assets/logo_st2023.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ],
            ),

            // keterangan ST
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Sensus Pertanian dilakukan setiap sepuluh tahun sekali yaitu pada tahun yang berakhiran 3 (tiga). Sensus Pertanian tahun 2023 (ST2023) merupakan Sensus Pertanian ketujuh. Tujuan utama dari kegiatan Sensus Pertanian adalah untuk mendapatkan data statistik pertanian yang lengkap dan akurat untuk bahan perencanaan dan evaluasi hasil-hasil pembangunan khususnya di sektor pertanian.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  //letterSpacing: 0.8,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            // latar belakang
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Card(
                  color: Colors.green.shade100,
                  child: ExpansionTile(
                    title: Text(
                      'Latar Belakang ST2023',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800),
                    ),
                    children: <Widget>[
                      BulletList([
                        'Data statistik dasar sektor pertanian secara lengkap dan menyeluruh dikumpulkan melalui kegiatan Sensus Pertanian (Undang-Undang Nomor 16 tahun 1997).',
                        'Sensus Pertanian dilakukan setiap sepuluh tahun sekali yaitu pada tahun yang berakhiran 3 (tiga). Sensus Pertanian yang akan datang dilaksanakan pada tahun 2023 merupakan sensus pertanian yang ketujuh, sensus pertanian yang pertama dilaksanakan pada tahun 1963.',
                        'Kontribusi pada perekonomian nasional: Terbukanya penyerapan tenaga kerja di sektor pertanian; Tingginya sumbangan devisa yang dihasilkan dari berkembang pesatnya sektor agribisnis maupun penghasil bahan baku bagi industri hilir yang mengolah hasil pertanian; Sektor pertanian dapat bertahan dalam masa pandemi Covid 19;',
                        'Diperlukan ketersediaan data sektor pertanian yang akurat dan terkini yang dapat digunakan sebagai acuan bagi pemerintah maupun stakeholder dalam merencanakan dan merumuskan kebijakan-kebijakan baik untuk kepentingan internal maupun untuk pembangunan nasional.',
                      ])
                    ],
                  ),
                ),
              ),
            ),

            // tujuan
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: Colors.green.shade100,
                child: ExpansionTile(
                  title: Text(
                    'Tujuan Utama ST2023',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800),
                  ),
                  children: <Widget>[
                    BulletList([
                      'Menyediakan data struktur pertanian, terutama unit wilayah terkecil.',
                      'Menyediakan data yang dapat digunakan sebagai tolak ukur statistik pertanian saat ini.',
                      'Menyediakan kerangka sampel untuk survei pertanian lanjutan.'
                    ])
                  ],
                ),
              ),
            ),

            //output
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: Colors.green.shade100,
                child: ExpansionTile(
                  title: Text(
                    'Output ST2023',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800),
                  ),
                  children: <Widget>[
                    BulletList([
                      'Terintegrasi & berkelanjutan dengan AGRIS.',
                      'Data tabular & geospasial.',
                      'Komprehensif & memenuhi aspek kewilayahan - perluasan unit statistik pada ST2023.',
                      'Memenuhi agenda global - sesuai dengan variabel WCA2020.',
                      'Menangkap isu strategis pertanian nasional - 4 indikator SDGs Pertanian.',
                      'Memanfaatkan data administratif - SP2020 & Podes.',
                      'Memperhatikan cost effective tools and methodology.',
                    ])
                  ],
                ),
              ),
            ),

            //identifikasi 1
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: Colors.green.shade100,
                child: ExpansionTile(
                  title: Text(
                    'Identifikasi Usaha Pertanian',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800),
                  ),
                  subtitle: Text(
                    'Oleh BPS Provinsi Kepulauan Bangka Belitung',
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Klik gambar untuk melihat lebih jelas',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    InstaImageViewer(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              'assets/identifikasi.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //identifikasi 2
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: Colors.green.shade100,
                child: ExpansionTile(
                  title: Text(
                    'Identifikasi Usaha Kehutanan Lainnya',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800),
                  ),
                  subtitle: Text(
                    'Oleh Tim Statistik Kehutanan BPS RI',
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Klik gambar untuk melihat lebih jelas',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    InstaImageViewer(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              'assets/penanganan.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InstaImageViewer(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              'assets/pemungutan.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InstaImageViewer(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              'assets/perburuan.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
