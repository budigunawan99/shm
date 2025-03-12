import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shm/model/input_data_screen_argument.dart';
import 'package:shm/provider/input_image_provider.dart';
import 'package:shm/widgets/appbar.dart';
import 'package:shm/widgets/input_image_grid.dart';

class InputDataScreen extends StatefulWidget {
  final InputDataScreenArgument args;

  const InputDataScreen({
    super.key,
    required this.args,
  });

  @override
  State<InputDataScreen> createState() => _InputDataScreenState();
}

class _InputDataScreenState extends State<InputDataScreen> {
  String _code = "";
  String _title = "";
  String _description = "";

  late final TextEditingController _codeController = TextEditingController();
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _descriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    print("Test ${widget.args.actionPage.isEdit}");

    if (widget.args.actionPage.isEdit) {
      _code = widget.args.product?.code ?? "";
      _title = widget.args.product?.title ?? "";
      _description = widget.args.product?.description ?? "";

      _codeController.text = _code;
      _titleController.text = _title;
      _descriptionController.text = _description;

      Future.microtask(() {
        List<String>? path = widget.args.product?.imagePath ?? <String>[];
        context.read<InputImageProvider>().setAllImages(path);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        isFirstPage: false,
        title: "Input Data",
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kode Produk",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                // controller: _titleController,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
                maxLength: 20,
                onChanged: (value) {
                  _code = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Nama Produk",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                // controller: _titleController,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
                maxLength: 20,
                onChanged: (value) {
                  _title = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Deskripsi Produk",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                // controller: _titleController,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
                maxLength: 50,
                onChanged: (value) {
                  _description = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tambah Gambar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Expanded(
                child: InputImageGrid(),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
