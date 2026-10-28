import 'package:flutter/material.dart';
class DocEditorScreen extends StatefulWidget {
  const DocEditorScreen({super.key});
  @override
  State<DocEditorScreen> createState() => _DocEditorScreenState();
}
class _DocEditorScreenState extends State<DocEditorScreen> {
  final _ctrl = TextEditingController(); double _fontSize = 16;
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('محرر النصوص'), actions: [
        IconButton(icon: const Icon(Icons.text_increase), onPressed: () => setState(() => _fontSize += 2)),
        IconButton(icon: const Icon(Icons.text_decrease), onPressed: () => setState(() => _fontSize = (_fontSize - 2).clamp(10, 48))),
      ]),
      body: Padding(padding: const EdgeInsets.all(16), child: TextField(controller: _ctrl, maxLines: null, expands: true, textAlignVertical: TextAlignVertical.top, style: TextStyle(fontSize: _fontSize, height: 1.6), decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'ابدأ الكتابة…'))),
    );
  }
}
