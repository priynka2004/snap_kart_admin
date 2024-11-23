import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/add_category_model.dart';
import '../provider/category_provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final nameController = TextEditingController();

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
                    title: const Text('Delete All Categories'),
                    content: const Text('Are you sure you want to delete all categories?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
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
                    const SnackBar(content: Text('All categories deleted successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete categories: $e')),
                  );
                }
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),

      body: getBody(),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          mainTextFormField(nameController, 'Category Name'),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: addCategoryButton,
              child: Text(
                'Add  Category',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addCategoryButton() async {
    String name = nameController.text;
    CategoryProvider provider =
        Provider.of<CategoryProvider>(context, listen: false);
    Category category = Category(
      name: name,
    );
    await provider.addCategory(category);
    Navigator.pop(context);
  }

  Widget mainTextFormField(controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}
