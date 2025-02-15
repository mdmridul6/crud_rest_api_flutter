import 'dart:convert';

import 'package:crud_app/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _productPriceTEController =
      TextEditingController();
  final TextEditingController _productQuantityTEController =
      TextEditingController();
  final TextEditingController _productImageTEController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTEController.text = widget.product.name;
    _productPriceTEController.text = widget.product.price.toString();
    _productQuantityTEController.text = widget.product.quantity.toString();
    _productImageTEController.text = widget.product.image_url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
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
                Visibility(
                  visible: _isLoading == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        _updateProduct();
                      }
                      return;
                    },
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _isLoading = true;
    setState(() {});
    String url = 'http://192.168.31.88:8000/api/product/${widget.product.id}';
    Uri uri = Uri.parse(url);
    Map<String, dynamic> inputData = {
      "name": _nameTEController.text,
      "price": _productPriceTEController.text,
      "quantity": _productQuantityTEController.text,
      "image_url": "http://192.168.31.88:8000/images/Dollify.png"
    };
    Response response = await put(
      uri,
      headers: {'content-type': 'application/json'},
      body: jsonEncode(inputData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Product update successfully'),
        ),
      );
      Navigator.pop(context, true);

    } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Product update Failed'),
          ),
        );
    }

    _isLoading = false;
    setState(() {});
  }
}
