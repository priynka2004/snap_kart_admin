import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/category/model/add_category_model.dart';

import '../provider/category_provider.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsScreen({required this.category, super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Add Category'),
        actions: [
          IconButton(
            onPressed: () async {
              final shouldDelete = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete Categories'),
                    content: const Text('Are you sure you want to delete  categories?'),
                    actions: [
                      TextButton(
                        onPressed: (

                            ) => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );

              if (shouldDelete ?? false) {
                final categoryProvider =
                Provider.of<CategoryProvider>(context, listen: false);
                try {
                  await categoryProvider.deleteAllCategories();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(' categories deleted successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(' delete categories: $e')),
                  );
                }
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'CategoryName: ${category.name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('CategorysId:   ${category.sId}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            )),
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('CategoryIv:   ${category.iV}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            )),
          ],
        ),
      ),
    );
  }
}
