import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/product/model/add_product_model.dart';
import 'package:snap_kart_admin/product/provider/product_provider.dart';
import 'package:snap_kart_admin/product/view/product_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final discountController = TextEditingController();
  final stockController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    desController.dispose();
    priceController.dispose();
    categoryController.dispose();
    discountController.dispose();
    stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: GestureDetector( onTap: () {
          Navigator.pop(context);
        },child:const Icon(Icons.arrow_back_ios,color: Colors.white,),),
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            mainTextFormField(nameController, 'Product Name'),
            mainTextFormField(desController, 'Description'),
            mainTextFormField(priceController, 'Price', isNumberic: true),
            mainTextFormField(categoryController, 'Category'),
            mainTextFormField(discountController, 'Discount Amount',
                isNumberic: true),
            mainTextFormField(stockController, 'Stock', isNumberic: true),
            const SizedBox(height: 170),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 140),
                elevation: 3,
              ),
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    desController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    categoryController.text.isEmpty ||
                    discountController.text.isEmpty ||
                    stockController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please fill all fields",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                  return;
                }

                final product = ProductModel(
                  name: nameController.text,
                  description: desController.text,
                  price: double.parse(priceController.text),
                  categoryId: categoryController.text,
                  discountAmount: double.parse(discountController.text),
                  stock: int.parse(stockController.text),
                  image: '',
                  id: '',
                );

                final success = await Provider.of<ProductProvider>(context, listen: false)
                    .addProduct(product);

                if (success) {
                  Fluttertoast.showToast(
                    msg: "Product added successfully",
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(),
                    ),
                        (route) => false,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Failed to add product",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },


              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget mainTextFormField(TextEditingController controller, String hintText,
      {bool isNumberic = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumberic ? TextInputType.number : TextInputType.text,
        inputFormatters:
        isNumberic ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
