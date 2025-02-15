import 'dart:convert';

import 'package:crud_app/add_product_screen.dart';
import 'package:crud_app/product.dart';
import 'package:crud_app/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool _getProductList = true;
  final List<Product> _productLists = [];

  @override
  void initState() {
    super.initState();
    _getAllProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddProductScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: RefreshIndicator(
        onRefresh: _getAllProductList,
        child: Visibility(
          visible: _getProductList == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemBuilder: (context, index) =>
                _buildProductItems(_productLists[index]),
            itemCount: _productLists.length,
            separatorBuilder: (_, __) {
              return const Divider();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductItems(Product product) {
    return ListTile(
      leading: Image.network(
        product.image_url,
        height: 100,
        width: 100,
      ),
      title: Text(product.name),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text('Unite Price :${product.price}'),
          Text('Quantity : ${product.quantity}'),
          Text('TotalPrice : ${product.price * product.quantity}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UpdateProductScreen(product: product)),
                );
                if (result == true) {
                  _getAllProductList();
                }
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () => _showDeleteConformationDialog(product.id),
              icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }

  _showDeleteConformationDialog(id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete'),
        content: const Text('Are you sure to delete item?'),
        actions: [
          TextButton(
              onPressed: () {
                _deleteProductList(id);
                Navigator.pop(context);
              },
              child: const Text('Yes')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No')),
        ],
      ),
    );
  }

  Future<void> _getAllProductList() async {
    _getProductList = true;
    setState(() {});
    _productLists.clear();
    const String url = 'http://192.168.31.88:8000/api/product';
    Uri uri = Uri.parse(url);

    Response response = await get(uri);

    if (response.statusCode == 200) {
      final decodedJsonProduct = jsonDecode(response.body);
      var productsList = decodedJsonProduct['products'];
      for (Map<String, dynamic> p in productsList) {
        Product product = Product(
          id: p['id'],
          name: p['name'] ?? "",
          price: p['price'] ?? "",
          quantity: p['quantity'] ?? "",
          image_url: p['image_url'] ?? "",
        );
        _productLists.add(product);
      }
    }

    _getProductList = false;
    setState(() {});
  }

  Future<void> _deleteProductList(id) async {
    _getProductList = true;
    setState(() {});
    _productLists.clear();
    String url = 'http://192.168.31.88:8000/api/product/$id';
    Uri uri = Uri.parse(url);

    Response response = await delete(uri);

    if (response.statusCode == 200) {
      _getAllProductList();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Product delete successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Product delete failed'),
        ),
      );
    }

    _getProductList = false;
    setState(() {});
  }
}
