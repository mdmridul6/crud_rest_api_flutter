import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _productPriceTEController =
      TextEditingController();
  final TextEditingController _productQuantityTEController =
      TextEditingController();
  final TextEditingController _productImageTEController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _globalKey,
            child: Column(
              children: [
                TextFormField(

                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter Product Name';
                    }
                    return null;
                  },
                  controller: _nameTEController,
                  decoration: const InputDecoration(
                      labelText: 'Name', hintText: 'Name'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter Product Price';
                    }
                    return null;
                  },
                  controller: _productPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Price', hintText: 'Price'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter Product Quantity';
                    }
                    return null;
                  },
                  controller: _productQuantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Quantity', hintText: 'Quantity'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter Product Image';
                    }
                    return null;
                  },
                  controller: _productImageTEController,
                  decoration: const InputDecoration(
                      labelText: 'Image', hintText: 'Image'),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {}
                    return;
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
