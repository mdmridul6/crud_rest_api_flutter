import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
  bool _addNewProductInProgress = false;

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
            // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                Visibility(
                  visible: !_addNewProductInProgress,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        _onAddProductButton();
                      }
                    },
                    child: const Text('Add'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onAddProductButton() async {
    _addNewProductInProgress = true;
    setState(() {});
    Map<String, dynamic> inputData = {
      "name": _nameTEController.text,
      "price": _productPriceTEController.text,
      "quantity": _productQuantityTEController.text,
      "image_url": "http://192.168.31.88:8000/images/Dollify.png"
    };
    const String addNewProductUrl = "http://192.168.31.88:8000/api/product";
    Uri uri = Uri.parse(addNewProductUrl);
    Response response = await post(
      uri,
      body: jsonEncode(inputData),
      headers: {'content-type': 'application/json'},
    );
    _addNewProductInProgress = false;
    setState(() {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      _nameTEController.clear();
      _productPriceTEController.clear();
      _productQuantityTEController.clear();
      _productImageTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product create successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Product create Failed'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _productPriceTEController.dispose();
    _productQuantityTEController.dispose();
    _productImageTEController.dispose();
    super.dispose();
  }
}
