import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_exercise/API/firebase_api.dart';
import 'package:flutter_exercise/models/firebase_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  late Future<List<FirebaseFile>> futureFiles;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll("Assets");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Aset'),
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
      body: FutureBuilder<List<FirebaseFile>>(
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
