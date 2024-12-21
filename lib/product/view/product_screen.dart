import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:snap_kart_admin/product/view/product_details_screen.dart';
import 'package:snap_kart_admin/product/view/add_product_screen.dart';  // Import AddProductScreen

import '../provider/product_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ImagePicker _picker = ImagePicker();
  int selectedIndex = 0;

  Future<void> fetchProduct() async {
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);
    await productProvider.fetchProduct();
  }

  Future<void> _pickImage(int index) async {
    if (kIsWeb) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      Provider.of<ProductProvider>(context, listen: false)
                          .updateProductImage(index, pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a photo'),
                onTap: () async {
                  final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      Provider.of<ProductProvider>(context, listen: false)
                          .updateProductImage(index, pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  final XFile? pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      Provider.of<ProductProvider>(context, listen: false)
                          .updateProductImage(index, pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Product ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu, color: Colors.white),
          )
        ],
      ),
      body: Consumer<ProductProvider>(builder: (context, productProvider, child) {
        if (productProvider.productList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: productProvider.productList.length,
                  itemBuilder: (context, index) {
                    final product = productProvider.productList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        child: Column(
                          children: [
                            Image.network(
                              product.image ??
                                  'https://example.com/default-image.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.name ?? "Unnamed Product",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '\$${product.price?.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return ListView.builder(
                itemCount: productProvider.productList.length,
                itemBuilder: (context, index) {
                  final product = productProvider.productList[index];
                  return Card(
                    shadowColor: Colors.black,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                      leading: GestureDetector(
                        onTap: () => _pickImage(index),
                        child: CircleAvatar(
                          backgroundImage: product.image?.isNotEmpty == true
                              ? NetworkImage(product.image!)
                              : const NetworkImage(
                              'https://example.com/default-image.jpg'),
                          radius: 30,
                        ),
                      ),
                      title: Text(
                        product.name ?? "Unnamed Product",
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                      subtitle: Text(
                        product.description ?? "No description available",
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        '₹${product.price ?? "N/A"}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      }),

      // Floating Action Button to Add Product
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()), // Navigate to AddProductScreen
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
