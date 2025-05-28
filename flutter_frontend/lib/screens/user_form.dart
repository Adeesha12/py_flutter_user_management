import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  File? _image;
  final _name = TextEditingController();
  final _email = TextEditingController();

  Future pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      final response = await ApiService.createUser({
        'name': _name.text,
        'email': _email.text,
      }, _image);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User created')));
        _name.clear();
        _email.clear();
        setState(() {
          _image = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                validator: (value) => value!.isEmpty ? 'Name is required' : null,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _email,
                validator: (value) =>
                    value!.contains('@') ? null : 'Invalid email',
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              _image != null
                  ? Image.file(_image!, height: 100)
                  : Text("No image selected"),
              ElevatedButton(onPressed: pickImage, child: Text('Pick Profile Picture')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
