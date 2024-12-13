

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/category/provider/category_provider.dart';
import 'package:snap_kart_admin/category/view/add_category_screen.dart';
import 'package:snap_kart_admin/category/view/category_detail_screen.dart';

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
    categoryProvider.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Category ",style: TextStyle(color: Colors.white),),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategoryScreen()),
          );
          CategoryProvider categoryProvider =
              Provider.of<CategoryProvider>(context, listen: false);
          categoryProvider.fetchCategories();
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.categoryList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return LayoutBuilder(
            builder: (context, constraints) {
// Web support (larger screen)
              if (constraints.maxWidth > 600) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: categoryProvider.categoryList.length,
                  itemBuilder: (context, index) {
                    final category = categoryProvider.categoryList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryDetailsScreen(
                            category: category,
                          );
                        }));
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  category.name ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {

                return ListView.builder(
                  itemCount: categoryProvider.categoryList.length,
                  itemBuilder: (context, index) {
                    final category = categoryProvider.categoryList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CategoryDetailsScreen(
                              category: category,
                            );
                          }));
                        },
                        title: Text(
                          category.name ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(category.sId.toString()),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
