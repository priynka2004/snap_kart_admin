import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/category/provider/category_provider.dart';
import 'package:snap_kart_admin/category/view/add_category_screen.dart';

import 'view/category_detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    fetchCategory();
    super.initState();
  }

  Future fetchCategory() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Category Screen",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddCategoryScreen()));
            CategoryProvider categoryProvider =
                Provider.of<CategoryProvider>(context, listen: false);
            categoryProvider.fetchCategory();
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            if (categoryProvider.categoryList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: categoryProvider.categoryList.length,
              itemBuilder: (context, index) {
                final category = categoryProvider.categoryList[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CategoryDetailsScreen(
                          category: category,
                        );
                      }));
                    },
                    title: Text(category.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      category.sId.toString(),
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
