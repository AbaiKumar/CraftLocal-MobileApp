// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modal/modal.dart';

class MyContactForm extends StatefulWidget {
  const MyContactForm({super.key});

  @override
  State<MyContactForm> createState() => _MyContactFormState();
}

class _MyContactFormState extends State<MyContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> save(BuildContext context, CraftLocalProvider obj) async {
    String res = await obj.contact(
      _nameController.text,
      _emailController.text,
      _messageController.text,
    );
    if (res == "Yes") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Reported successfully"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Operation Failed"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<CraftLocalProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: const Text("name"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your name.'
                    : null,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: const Text("email"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                controller: _emailController,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  label: const Text("message"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your message.'
                    : null,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    save(context, obj);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
