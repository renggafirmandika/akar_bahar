import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_exercise/API/firebase_api.dart';
import 'package:flutter_exercise/models/firebase_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  late Future<List<FirebaseFile>> futureFiles;
  late Future<List<FirebaseFile>> futureFiles2;
  Map<int, double> downloadProgress = {};
  Future<void>? _launched;

  PackageInfo _packageInfo =
      PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll("Assets");
    futureFiles2 = FirebaseApi.listAll("APK/Newest");
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Tidak bisa membuka link';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch =
        Uri(scheme: 'https', host: 's.bps.go.id', path: '/kodest23');
    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                child: ExpansionTile(
                  leading: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 40,
                    color: Colors.green.shade700,
                  ),
                  title: Text(
                    'Download Aset',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  children: [
                    FutureBuilder<List<FirebaseFile>>(
                      future: futureFiles,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error'),
                              );
                            } else {
                              final files = snapshot.data!;

                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: files.length,
                                  itemBuilder: (context, index) {
                                    final file = files[index];
                                    double? progress = downloadProgress[index];

                                    return ListTile(
                                      title: Text(file.name),
                                      subtitle: progress != null
                                          ? LinearProgressIndicator(
                                              value: progress,
                                              backgroundColor: Colors.black26,
                                            )
                                          : null,
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.download,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          downloadFile(index, file.ref);
                                        },
                                      ),
                                    );
                                  });
                            }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                child: ExpansionTile(
                  leading: Icon(
                    Icons.get_app_outlined,
                    size: 40,
                    color: Colors.green.shade700,
                  ),
                  title: Text(
                    'Download APK',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  children: [
                    FutureBuilder<List<FirebaseFile>>(
                      future: futureFiles2,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error'),
                              );
                            } else {
                              final files = snapshot.data!;
                              final file = files[0];

                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Table(
                                          border: TableBorder.all(
                                              color: Colors.grey.shade800),
                                          children: [
                                            TableRow(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Versi APK Saat ini",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Versi APK Terbaru",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    _packageInfo.version,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    child: Text(
                                                      p
                                                          .basenameWithoutExtension(
                                                              file.name)
                                                          .substring(11)
                                                          .replaceAll('_', '.'),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blue.shade800),
                                                    ),
                                                    onTap: () => setState(() {
                                                      _launched =
                                                          _launchInBrowser(
                                                              toLaunch);
                                                    }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              // return GridView.builder(
                              //     itemCount: files.length,
                              //     gridDelegate:
                              //         const SliverGridDelegateWithMaxCrossAxisExtent(
                              //             maxCrossAxisExtent: 200,
                              //             childAspectRatio: 3 / 2,
                              //             crossAxisSpacing: 20,
                              //             mainAxisSpacing: 20),
                              //     itemBuilder: (context, index) {
                              //       final file = files[index];
                              //       double? progress = downloadProgress[index];

                              //       return ListTile(
                              //         title: Text(file.name),
                              //         subtitle: progress != null
                              //             ? LinearProgressIndicator(
                              //                 value: progress,
                              //                 backgroundColor: Colors.black26,
                              //               )
                              //             : null,
                              //         trailing: IconButton(
                              //           icon: const Icon(
                              //             Icons.download,
                              //             color: Colors.black,
                              //           ),
                              //           onPressed: () {
                              //             downloadFile(index, file.ref);
                              //           },
                              //         ),
                              //       );
                              //     });
                            }
                        }
                      },
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

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/${ref.name}';
    final file = io.File(path);

    await Dio().download(
      url,
      path,
      onReceiveProgress: (count, total) {
        double progress = count / total;

        setState(() {
          downloadProgress[index] = progress;
        });
      },
    );

    //await ref.writeToFile(file);

    final bytes = file.readAsBytesSync();

    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      final filename = p.basename(file.name);
      if (file.isFile) {
        final data = file.content as List<int>;
        io.File('${dir.path}/${filename}')
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }

    imageCache.clearLiveImages();
    imageCache.clear();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File ${ref.name} berhasil didownload!')));
  }
}

// const kTableColumns = <DataColumn>[
//   DataColumn(
//     label: Text(
//       'Versi APK Saat Ini',
//       style: TextStyle(fontWeight: FontWeight.bold),
//     ),
//   ),
//   DataColumn(
//     label: Text(
//       'Versi APK Terbaru',
//       style: TextStyle(fontWeight: FontWeight.bold),
//     ),
//   ),
// ];
