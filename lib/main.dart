import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kelaniDATA',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String alYear = '';
  String nic = '';

  // List of PDFs with their identifiers
  // and display labels
  final List<Map<String, String>> pdfs = [
    {'id': 'nic', 'label': 'NIC Document', 'filename': 'nic.pdf'},
    {'id': 'al', 'label': 'A/L Certificate', 'filename': 'al.pdf'},
    {'id': 'ol', 'label': 'O/L Certificate', 'filename': 'ol.pdf'},
    {'id': 'fi', 'label': "Father's Income", 'filename': 'fi.pdf'},
    {'id': 'mi', 'label': "Mother's Income", 'filename': 'mi.pdf'},
    {'id': 'nee1', 'label': 'Details', 'filename': 'nee1.pdf'},
  ];

  @override
  void dispose() {
    super.dispose();
    // Delete existing PDF files when the app close
    _deleteExistingPDFFiles();
  }

  Future<void> _deleteExistingPDFFiles() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      for (var pdf in pdfs) {
        final file = File('${directory.path}/${pdf['filename']}');
        if (await file.exists()) {
          await file.delete();
        }
      }
    } catch (e) {
      // Handle any errors during deletion
      print('Error deleting files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('kelaniDATA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter A/L Year',
                hintText: '20XX',
              ),
              onChanged: (value) {
                setState(() {
                  alYear = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter NIC',
                hintText: '200XXXXXXXXX',
              ),
              onChanged: (value) {
                setState(() {
                  nic = value;
                });
              },
            ),
            const SizedBox(height: 50),
            // Generate buttons dynamically
            ...pdfs.map((pdf) => Expanded(
                  child: TextButton(
                    //color: Colors.green,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),

                    onPressed: () async {
                      if (alYear.isNotEmpty && nic.isNotEmpty) {
                        // protect my Data
                        final String apiUrl =
                            'https://mis.kln.ac.lk/storage/files/$alYear/$nic/${pdf['filename']}';
                        final filePath =
                            await downloadFile(apiUrl, pdf['filename']!);
                        if (filePath != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PDFViewer(filePath: filePath),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to download PDF.'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter both A/L Year and NIC.'),
                          ),
                        );
                      }
                    },
                    child: Text(pdf['label']!),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<String?> downloadFile(String url, String fileName) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class PDFViewer extends StatelessWidget {
  final String filePath;
  const PDFViewer({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('kelaniDATA PDF Viewer'),
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
