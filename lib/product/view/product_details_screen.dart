import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/product/view/update_product_screen.dart';
import '../../cart/model/cart_model.dart';
import '../../cart/provider/cart_provider.dart';
import '../../cart/view/cart_screen.dart';
import '../model/add_product_model.dart';
import '../model/product_model.dart';
import '../provider/product_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({required this.product, super.key});

  final ProductModel product;

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _showDeleteDialog(context, widget.product),
            icon: const Icon(Icons.delete, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProductScreen(product: widget.product),
                ),
              );
            },
            icon: const Icon(Icons.update, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.blueGrey,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          widget.product.name ?? "Product Details",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard('Name', widget.product.name),
              _buildCard('Price', '₹${widget.product.price ?? ""}'),
              _buildDescriptionCard('Description', widget.product.description),
              _buildCard('Category', widget.product.categoryId),
              _buildCard('Stock', widget.product.stock.toString()),
              _buildCard('Discount Amount', '₹${widget.product.discountAmount ?? ""}'),
              const SizedBox(height: 340),
              ElevatedButton(
                onPressed: () async {
                  final cartModel = CartModel(
                    productId: widget.product.id,
                    quantity: 1,
                  );
                  await Provider.of<CartProvider>(context, listen: false).addToCart(cartModel);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CartScreen();
                  }));
                  await Provider.of<CartProvider>(context, listen: false).fetchCartItems();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Center(
                  child: Text("Add to Cart", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this product?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final deleteProvider = Provider.of<ProductProvider>(context, listen: false);
                if (product.id != null) {
                  bool success = await deleteProvider.deleteProduct(product.id!);
                  Navigator.pop(context);
                  if (success) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(deleteProvider.errorMessage ?? "Error deleting product"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCard(String label, String? value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              value ?? "N/A",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(String label, String? value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value ?? "N/A",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
