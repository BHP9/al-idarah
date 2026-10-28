import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:archive/archive.dart';

class PdfHomeScreen extends StatefulWidget {
  const PdfHomeScreen({super.key});
  @override
  State<PdfHomeScreen> createState() => _PdfHomeScreenState();
}
class _PdfHomeScreenState extends State<PdfHomeScreen> {
  String _status = 'اختر ملف DOCX لتحويله إلى PDF';
  Future<void> _pickAndConvert() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['docx'], withData: true);
    if (result == null || result.files.single.bytes == null) return;
    setState(() => _status = 'جاري التحويل…');
    try {
      final archive = ZipDecoder().decodeBytes(result.files.single.bytes!);
      final file = archive.findFile('word/document.xml');
      String text = file == null ? '' : String.fromCharCodes(file.content as List<int>).replaceAll(RegExp(r'<[^>]+>'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
      final doc = pw.Document();
      doc.addPage(pw.MultiPage(pageFormat: PdfPageFormat.a4, build: (_) => [pw.Paragraph(text: text.isEmpty ? '(لا يوجد نص)' : text)]));
      final pdfBytes = await doc.save();
      final dir = await getTemporaryDirectory();
      final out = File('${dir.path}/converted_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await out.writeAsBytes(pdfBytes);
      setState(() => _status = 'تم: ${out.path}');
      await Share.shareXFiles([XFile(out.path)]);
    } catch (e) { setState(() => _status = 'خطأ: $e'); }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مركز PDF')),
      body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
        ElevatedButton.icon(onPressed: _pickAndConvert, icon: const Icon(Icons.upload_file), label: const Text('DOCX → PDF')),
        const SizedBox(height: 16), Text(_status, textAlign: TextAlign.center),
      ]))),
    );
  }
}
