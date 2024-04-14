import 'package:flutter/material.dart';
import 'package:flutter_customerfeedback_api/api_handler.dart';
import 'package:flutter_customerfeedback_api/model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final User user;
  const EditPage({super.key, required this.user});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();
  late http.Response response;

  void updateData() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      final user = User(
        userId: widget.user.userId,
        name: data['name'],
        email: data['email'],
        role: data['role'],
      );

      response =
          await apiHandler.updateUser(userId: widget.user.userId, user: user);
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Page"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: updateData, //Navigation for update & return to home page
        child: const Text('Update'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: FormBuilder(
            key: _formKey,
            initialValue: {
              'name': widget.user.name,
              'email': widget.user.email,
              'role': widget.user.role,
            },
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  name: 'role',
                  decoration: const InputDecoration(labelText: 'Role'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}
