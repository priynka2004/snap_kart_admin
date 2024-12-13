import 'package:flutter/material.dart';
import 'package:snap_kart_admin/profile/model/shipping_address_model.dart' show ShippingAddress;

class AddShippingAddresScreen extends StatefulWidget {

  const AddShippingAddresScreen({Key? key, }):super(key: key);


  @override
  State<AddShippingAddresScreen> createState() => _AddShippingAddresScreenState();
}

class _AddShippingAddresScreenState extends State<AddShippingAddresScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _streetController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _postalCodeController = TextEditingController();

  final TextEditingController _countryController = TextEditingController();

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      ShippingAddress shippingAddress = ShippingAddress(
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        postalCode: _postalCodeController.text,
        country: _countryController.text,
      );
      Navigator.pop(context,shippingAddress);


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Shipping Address",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
        leading: GestureDetector( onTap: () {
          Navigator.pop(context);
        },child:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _streetController,
                  decoration: const InputDecoration(labelText: "Street"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the street";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: "City"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the city";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(labelText: "State"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the state";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _postalCodeController,
                  decoration: const InputDecoration(labelText: "Postal Code"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the postal code";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: "Country"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the country";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 300),
                ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
                    elevation: 3,
                  ),
                  child: const Text("Save Address",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

