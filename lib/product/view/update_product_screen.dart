import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/product/model/add_product_model.dart';
import 'package:snap_kart_admin/product/provider/product_provider.dart';
import 'package:snap_kart_admin/service/app_util.dart';


class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({required this.product, super.key});

  final ProductModel product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController discountAmountController;
  late TextEditingController stockController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    priceController = TextEditingController(
      text: widget.product.price?.toString() ?? '',
    );
    descriptionController =
        TextEditingController(text: widget.product.description);
    categoryController = TextEditingController(text: widget.product.categoryId);
    discountAmountController =
        TextEditingController(text: widget.product.discountAmount?.toString());
    stockController = TextEditingController(
        text: widget.product.stock?.toString() ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    discountAmountController.dispose();
    stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),

            // Price
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            // Description
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 12),

            // Category
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: discountAmountController,
              decoration: const InputDecoration(labelText: 'Discount Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            // Stock
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 240),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              onPressed: () async {
                final priceText = priceController.text.trim();
                final price = double.tryParse(priceText);

                if (price == null) {
                  AppUtil.showToast('Please enter a valid price');
                  return;
                }

                if (nameController.text.trim().isEmpty) {
                  AppUtil.showToast('Please enter a valid product name');
                  return;
                }

                if (categoryController.text.trim().isEmpty) {
                  AppUtil.showToast('Please select a valid category');
                  return;
                }

                if (stockController.text.trim().isEmpty) {
                  AppUtil.showToast('Please enter a valid stock quantity');
                  return;
                }

                final discountAmountText = discountAmountController.text.trim();
                final discountAmount = double.tryParse(discountAmountText);

                final updatedProduct = ProductModel(
                  id: widget.product.id,
                  name: nameController.text.trim(),
                  price: price,
                  description: descriptionController.text.trim(),
                  image: widget.product.image,
                  discountAmount: discountAmount ?? 0,
                  stock: int.tryParse(stockController.text.trim()) ?? 0,
                  categoryId: categoryController.text.trim(),
                  created: widget.product.created,
                  modified: DateTime.now().millisecondsSinceEpoch,
                );

                final productProvider =
                Provider.of<ProductProvider>(context, listen: false);

                bool success = await productProvider.updateProduct(updatedProduct);

                if (success) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  AppUtil.showToast('Product updated successfully');
                } else {
                  AppUtil.showToast(
                      productProvider.errorMessage ?? 'Failed to update product');
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
