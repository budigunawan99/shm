import 'package:flutter/material.dart';
import 'package:shm/widgets/appbar.dart';
import 'package:shm/widgets/input_image_grid.dart';

class InputDataScreen extends StatefulWidget {
  const InputDataScreen({super.key});

  @override
  State<InputDataScreen> createState() => _InputDataScreenState();
}

class _InputDataScreenState extends State<InputDataScreen> {
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
              onChanged: (value) {},
            ),
            const Text(
              "Tambah Gambar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
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
    );
  }
}
