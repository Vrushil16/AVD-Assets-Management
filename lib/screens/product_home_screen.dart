import 'dart:io';
import 'package:asset_mangement/models/product_model.dart';
import 'package:asset_mangement/providers/product_provider.dart';
import 'package:asset_mangement/utils/common_app_bar.dart';
import 'package:asset_mangement/utils/common_textfields.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 0;
  String _owner = '';
  String _location = '';
  List<String> _imagePaths = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _imagePaths = pickedFiles.map((file) => file.path).toList();
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imagePaths.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Add Product",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  label: "Product Name",
                  onSaved: (value) => _name = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Price",
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _price = double.parse(value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Owner",
                  onSaved: (value) => _owner = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an owner name';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Location",
                  onSaved: (value) => _location = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _imagePaths.isEmpty
                    ? const Text("No images selected.", textAlign: TextAlign.center)
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: _imagePaths.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Image.file(
                                File(_imagePaths[index]),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () => _removeImage(index),
                                  child: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.white,
                                    size: 22.5,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                const SizedBox(height: 20),
                TextButton.icon(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.image, color: Colors.blue),
                  label: const Text("Pick Images", style: TextStyle(color: Colors.blue)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final product = Product(
                        name: _name,
                        price: _price,
                        owner: _owner,
                        location: _location,
                        imagePaths: _imagePaths,
                      );

                      Provider.of<ProductProvider>(context, listen: false).addProduct(product);
                      Navigator.pop(context);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: const BorderSide(color: Colors.green, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Save", style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
