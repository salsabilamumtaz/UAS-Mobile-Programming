import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note Harian',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotebookPage(),
    );
  }
}

class NotebookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Harian'),
      ),
      body: Notebook(),
    );
  }
}

class Notebook extends StatelessWidget {
  final List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,  // Jumlah kolom
          childAspectRatio: 3 / 4,  // Rasio tinggi terhadap lebar
        ),
        itemCount: days.length, 
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    days[index],  // Nama hari
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, lineIndex) {
                        return LineWithUnderline();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LineWithUnderline extends StatefulWidget {
  @override
  _LineWithUnderlineState createState() => _LineWithUnderlineState();
}

class _LineWithUnderlineState extends State<LineWithUnderline> {
  bool _isChecked = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_update);
  }

  @override
  void dispose() {
    _controller.removeListener(_update);
    _controller.dispose();
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (_controller.text.isNotEmpty)
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
              ),
            Expanded(
              child: Container(
                height: 30,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 8),  
                  ),
                  style: TextStyle(
                    decoration: _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(  // Garis bawah
          color: Colors.black,
        ),
      ],
    );
  }
}
