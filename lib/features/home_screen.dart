import 'package:flutter/material.dart';
import 'docs/ui/doc_editor_screen.dart';
import 'sheets/ui/sheet_screen.dart';
import 'pdf/ui/pdf_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      _Tile('مستند جديد', Icons.description, () => _push(context, const DocEditorScreen())),
      _Tile('جدول جديد', Icons.grid_on, () => _push(context, const SheetScreen())),
      _Tile('مركز PDF', Icons.picture_as_pdf, () => _push(context, const PdfHomeScreen())),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('الإدارة')),
      body: GridView.count(
        crossAxisCount: 2, padding: const EdgeInsets.all(16), crossAxisSpacing: 12, mainAxisSpacing: 12,
        children: items.map((t) => Card(child: InkWell(onTap: t.onTap, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(t.icon, size: 48), const SizedBox(height: 8), Text(t.label, style: const TextStyle(fontSize: 16))])))).toList(),
      ),
    );
  }
  void _push(BuildContext c, Widget w) => Navigator.of(c).push(MaterialPageRoute(builder: (_) => w));
}
class _Tile {
  final String label; final IconData icon; final VoidCallback onTap;
  _Tile(this.label, this.icon, this.onTap);
}
