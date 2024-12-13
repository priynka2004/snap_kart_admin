import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/category/provider/category_provider.dart';

class UpdateCategory extends StatefulWidget {
  final String categoryId;
  final String currentName;
  final String currentDescription;

  const UpdateCategory({
    super.key,
    required this.categoryId,
    required this.currentName,
    required this.currentDescription,
  });

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _descriptionController = TextEditingController(text: widget.currentDescription);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void saveCategory() async {
    final String name = _nameController.text.trim();
    final String description = _descriptionController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category name is required")),
      );
      return;
    }

    final provider = Provider.of<CategoryProvider>(context, listen: false);

    try {
      bool isUpdated = await provider.updateCategory(widget.categoryId, name, description);
      if (isUpdated) {
        await provider.fetchCategories();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category '$name' updated successfully!")),
        );
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update category")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void cancelUpdate() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: GestureDetector( onTap: () {
         // Navigator.pop(context);
          Navigator.pop(context);
        },child:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: const Text("Update Category",style: TextStyle(color: Colors.white),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Category Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter category name",
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Description ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter category description",
              ),
            ),
         Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: cancelUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
                  ),
                  child: const Text("Cancel",style: TextStyle(color: Colors.white),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  ),
                  onPressed: saveCategory,
                  child: const Text("Save",style: TextStyle(color: Colors.white)),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
