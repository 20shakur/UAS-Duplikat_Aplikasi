import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ColorPickerApp());
}

class ColorPickerApp extends StatefulWidget {
  const ColorPickerApp({super.key});

  @override
  _ColorPickerAppState createState() => _ColorPickerAppState();
}

class _ColorPickerAppState extends State<ColorPickerApp> {
  bool isDarkMode = false;
  Color selectedColor = Colors.green;

  void onColorChanged(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void onDarkModeChanged(bool isDark) {
    setState(() {
      isDarkMode = isDark;
    });
  }

  List<Color> generateColors() {
    List<Color> colors = [];
    for (int i = 0; i < 49; i++) {
      colors.add(Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = generateColors();

    return MaterialApp(
      title: 'Keep My Notes',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Catatan'),
            backgroundColor: selectedColor,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              },
            ),
            actions: [
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                },
              ),
              const SizedBox(width: 15),
              IconButton(
                icon: const Icon(Icons.notes),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotesScreen()),
                  );
                },
              ),
              const SizedBox(width: 15),
              PopupMenuButton<String>(
                onSelected: (String result) {
                  setState(() {
                    if (result == 'Catatan') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewNoteScreen(selectedColor: selectedColor)),
                      );
                    }
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Catatan',
                    child: ListTile(
                      leading: Icon(Icons.note),
                      title: Text('Catatan'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Daftar periksa',
                    child: ListTile(
                      leading: Icon(Icons.check_box),
                      title: Text('Daftar periksa'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Tulisan tangan',
                    child: ListTile(
                      leading: Icon(Icons.brush),
                      title: Text('Tulisan tangan'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Rekaman suara',
                    child: ListTile(
                      leading: Icon(Icons.mic),
                      title: Text('Rekaman suara'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Map',
                    child: ListTile(
                      leading: Icon(Icons.folder),
                      title: Text('Map'),
                    ),
                  ),
                ],
                icon: const Icon(Icons.add),
              ),
              const SizedBox(width: 15),
            ],
          ),
          drawer: const Drawer(),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.white,
                border: Border.all(color: selectedColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Pemilihan warna',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: colors.map((color) {
                      return GestureDetector(
                        onTap: () => onColorChanged(color),
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          width: 30,
                          height: 30,
                          color: color,
                          child: selectedColor == color
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mode malam',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Switch(
                        value: isDarkMode,
                        onChanged: onDarkModeChanged,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(selectedColor),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  get selectedColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: selectedColor,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            _buildMenuItem(Icons.settings, 'Pengaturan'),
            _buildMenuItem(Icons.delete, 'Tempat Sampah'),
            _buildMenuItem(Icons.backup, 'Cadangkan dan pulihkan'),
            _buildMenuItem(Icons.sync, 'Sinkronisasi'),
            _buildMenuItem(Icons.share, 'Berbagi dengan teman'),
            _buildMenuItem(Icons.shopping_cart, 'Premium'),
            _buildMenuItem(Icons.apps, 'Lebih banyak aplikasi'),
            _buildMenuItem(Icons.star, 'Beri nilai pada aplikasi'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          // Handle menu item tap
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 50, color: Colors.green),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String? selectedOption;

  void onOptionSelected(String? value) {
    setState(() {
      selectedOption = value;
    });
  }

  void onConfirmSelection() {
    // Handle the confirmation of the selected option
    // For example, save it to a database or show a dialog
    if (selectedOption != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Option selected: $selectedOption')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: onConfirmSelection,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            RadioListTile(
              title: const Text('Judul'),
              value: 'Judul',
              groupValue: selectedOption,
              onChanged: onOptionSelected,
            ),
            RadioListTile(
              title: const Text('Tanggal dimodifikasi (terbaru pertama)'),
              value: 'Tanggal dimodifikasi (terbaru pertama)',
              groupValue: selectedOption,
              onChanged: onOptionSelected,
            ),
            RadioListTile(
              title: const Text('Tanggal dimodifikasi (tertua pertama)'),
              value: 'Tanggal dimodifikasi (tertua pertama)',
              groupValue: selectedOption,
              onChanged: onOptionSelected,
            ),
            RadioListTile(
              title: const Text('Tanggal dibuat (terbaru pertama)'),
              value: 'Tanggal dibuat (terbaru pertama)',
              groupValue: selectedOption,
              onChanged: onOptionSelected,
            ),
            RadioListTile(
              title: const Text('Tanggal dibuat (tertua pertama)'),
              value: 'Tanggal dibuat (tertua pertama)',
              groupValue: selectedOption,
              onChanged: onOptionSelected,
            ),
            RadioListTile(
              title: const Text('Warna'),
              value: 'Warna',
              groupValue: selectedOption,
              onChanged: onOptionSelected,
            ),
            RadioListTile(
              title: const Text('Ukuran catatan'),
              value: 'Ukuran catatan',
              groupValue: selectedOption,
              onChanged: onOptionSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const Center(
        child: Text('Search Screen'),
      ),
    );
  }
}

class NewNoteScreen extends StatefulWidget {
  final Color selectedColor;

  const NewNoteScreen({super.key, required this.selectedColor});

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  File? _image;

  List<String> _titleHistory = [];
  List<String> _noteHistory = [];
  int _titleHistoryIndex = -1;
  int _noteHistoryIndex = -1;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => _saveTitleToHistory());
    _noteController.addListener(() => _saveNoteToHistory());
  }

  void _saveTitleToHistory() {
    if (_titleHistoryIndex == -1 || _titleController.text != _titleHistory[_titleHistoryIndex]) {
      _titleHistory = _titleHistory.sublist(0, _titleHistoryIndex + 1);
      _titleHistory.add(_titleController.text);
      _titleHistoryIndex++;
    }
  }

  void _saveNoteToHistory() {
    if (_noteHistoryIndex == -1 || _noteController.text != _noteHistory[_noteHistoryIndex]) {
      _noteHistory = _noteHistory.sublist(0, _noteHistoryIndex + 1);
      _noteHistory.add(_noteController.text);
      _noteHistoryIndex++;
    }
  }

  void _undoTitle() {
    if (_titleHistoryIndex > 0) {
      _titleHistoryIndex--;
      _titleController.text = _titleHistory[_titleHistoryIndex];
    }
  }

  void _redoTitle() {
    if (_titleHistoryIndex < _titleHistory.length - 1) {
      _titleHistoryIndex++;
      _titleController.text = _titleHistory[_titleHistoryIndex];
    }
  }

  void _undoNote() {
    if (_noteHistoryIndex > 0) {
      _noteHistoryIndex--;
      _noteController.text = _noteHistory[_noteHistoryIndex];
    }
  }

  void _redoNote() {
    if (_noteHistoryIndex < _noteHistory.length - 1) {
      _noteHistoryIndex++;
      _noteController.text = _noteHistory[_noteHistoryIndex];
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _showTextInputDialog() async {
    TextEditingController textController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambahkan teks'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Masukkan teks'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Tambahkan'),
              onPressed: () {
                String inputText = textController.text;
                if (inputText.isNotEmpty) {
                  _addTextToNote(inputText);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addTextToNote(String text) {
    final int cursorPosition = _noteController.selection.baseOffset;
    final String newText = _noteController.text.replaceRange(
      cursorPosition,
      cursorPosition,
      text,
    );
    _noteController.text = newText;
    _noteController.selection = TextSelection.collapsed(offset: cursorPosition + text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.selectedColor,
        leading: IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            // Handle saving the note and popping the screen
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              _undoTitle();
              _undoNote();
            },
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              _redoTitle();
              _redoNote();
            },
          ),
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: _showTextInputDialog,
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImage,
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle additional menu actions
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul',
                labelStyle: TextStyle(color: widget.selectedColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.selectedColor),
                ),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Catatan',
                labelStyle: TextStyle(color: widget.selectedColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.selectedColor),
                ),
              ),
              maxLines: 10,
            ),
            const SizedBox(height: 6),
            if (_image != null) ...[
              Image.file(_image!),
              const SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
  }
}


 