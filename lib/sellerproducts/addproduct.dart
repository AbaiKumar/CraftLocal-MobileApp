// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../modal/modal.dart';

class CustomImagePicker {
  static final ImagePicker picker = ImagePicker();
  static Future<String?> pickImage(ImageSource way) async {
    final XFile? image = await picker.pickImage(source: way);
    return image?.path.toString();
  }
}

class ProductsAdd extends StatefulWidget {
  @override
  State<ProductsAdd> createState() => _ProductsAddState();
}

class _ProductsAddState extends State<ProductsAdd> {
  final _url = FocusNode();
  final _price = FocusNode();
  final _description = FocusNode();
  final _stock = FocusNode();
  final _glob = GlobalKey<FormState>();
  late String name = "", price = "", stock = "", description = "";
  String? pickedImage;

  @override
  void dispose() {
    _url.dispose();
    _price.dispose();
    _description.dispose();
    _stock.dispose();
    super.dispose();
  }

  void upload(BuildContext c, CraftLocalProvider obj) async {
    print(pickedImage);
    if (name == "" ||
        description == "" ||
        stock == "" ||
        price == "" ||
        pickedImage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Added all fields"),
        ),
      );
    }
    _glob.currentState?.save();
    obj.addProduct(name, description, stock, price, pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<CraftLocalProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        actions: [
          IconButton(
            onPressed: () => upload(context, obj),
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
            key: _glob,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  initialValue: name,
                  onChanged: (_) {
                    name = _.toString();
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_description);
                  },
                  onSaved: (_) {
                    name = _.toString();
                  },
                  validator: (str) {
                    if (str == null || str.isEmpty) {
                      return "Please mention name ";
                    } else if (str.length > 20) {
                      return "Enter name below 20 characters";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 300,
                  maxLines: 3,
                  focusNode: _description,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                  initialValue: description,
                  onChanged: (_) {
                    description = _.toString();
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_stock);
                  },
                  onSaved: (_) {
                    description = _.toString();
                  },
                  validator: (str) {
                    if (str == null || str.isEmpty) {
                      return "Please mention description ";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  focusNode: _stock,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Stock",
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_price);
                  },
                  onSaved: (str) {
                    stock = str.toString();
                  },
                  initialValue: stock,
                  validator: (str) {
                    if (str == null || str.isEmpty || double.parse(str) <= 0) {
                      return "Mention stock";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  focusNode: _price,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Price",
                  ),
                  initialValue: price,
                  onChanged: (_) {
                    price = _.toString();
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus();
                  },
                  onSaved: (_) {
                    price = _.toString();
                  },
                  validator: (str) {
                    if (str == null || str.isEmpty) {
                      return "Please mention price";
                    }
                    return null;
                  },
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      child: const Text("Pick Image"),
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          CustomImagePicker.pickImage(
                                              ImageSource.camera);
                                        },
                                        icon: const Icon(
                                            Icons.camera_alt_rounded),
                                        label: const Text("Camera"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() async {
                                            pickedImage =
                                                await CustomImagePicker
                                                    .pickImage(
                                              ImageSource.gallery,
                                            );
                                          });
                                        },
                                        icon: const Icon(Icons.photo),
                                        label: const Text("Gallery"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            _glob.currentState?.reset();
                          },
                          icon: const Icon(Icons.clear, color: Colors.red),
                          label: const Text('Clear'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                            ),
                            onPressed: () {
                              upload(context, obj);
                            },
                            icon: Icon(Icons.done_outlined,
                                color: Colors.green[800]),
                            label: const Text('Submit')),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
