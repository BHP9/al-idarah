import 'package:flutter/material.dart';
class SheetScreen extends StatefulWidget {
  const SheetScreen({super.key});
  @override
  State<SheetScreen> createState() => _SheetScreenState();
}
class _SheetScreenState extends State<SheetScreen> {
  static const _rows = 20; static const _cols = 6;
  late final List<List<TextEditingController>> _cells;
  @override
  void initState() { super.initState(); _cells = List.generate(_rows, (_) => List.generate(_cols, (_) => TextEditingController())); }
  @override
  void dispose() { for (final row in _cells) { for (final c in row) { c.dispose(); } } super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الجدول')),
      body: SingleChildScrollView(scrollDirection: Axis.horizontal, child: SingleChildScrollView(child: Table(
        border: TableBorder.all(color: Colors.grey.shade400), defaultColumnWidth: const FixedColumnWidth(120),
        children: List.generate(_rows, (r) => TableRow(children: List.generate(_cols, (c) => Padding(padding: const EdgeInsets.all(4), child: TextField(controller: _cells[r][c], decoration: const InputDecoration(border: InputBorder.none, isDense: true)))))),
      ))),
    );
  }
}
