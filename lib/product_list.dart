import 'package:crud_app/add_product_screen.dart';
import 'package:crud_app/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
      body: ListView.separated(
        itemBuilder: (context, index) => _buildProductItems(),
        itemCount: 10,
        separatorBuilder: (_, __) {
          return const Divider();
        },
      ),
    );
  }

  Widget _buildProductItems() => ListTile(
        leading: Image.network(
          'https://dummyimage.com/400x400/808080/fff',
          height: 100,
          width: 100,
        ),
        title: const Text('List title'),
        subtitle: const Wrap(
          spacing: 16,
          children: [
            Text('Unite Price'),
            Text('Quantity'),
            Text('TotalPrice'),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProductScreen()),
                  );
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () => _showDeleteConformationDialog(),
                icon: const Icon(Icons.delete)),
          ],
        ),
      );

  _showDeleteConformationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete'),
        content: const Text('Are you sure to delete item?'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Yes')),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('No')),
        ],
      ),
    );
  }
}
