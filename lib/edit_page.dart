import 'package:flutter/material.dart';
import 'package:flutter_customerfeedback_api/api_handler.dart';
import 'package:flutter_customerfeedback_api/model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final User user;
  final VoidCallback onUpdate;
  const EditPage({super.key, required this.user, required this.onUpdate});

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
        customerfeedback: data['customerfeedback'],
      );

      response =
          await apiHandler.updateUser(userId: widget.user.userId, user: user);

      // Call the onUpdate callback to trigger a refresh in MainPage
      widget.onUpdate();
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
        backgroundColor: const Color.fromARGB(255, 187, 239, 248),
        foregroundColor: const Color.fromARGB(255, 7, 7, 7),
      ),
      bottomNavigationBar: MaterialButton(
        color: const Color.fromARGB(255, 187, 239, 248),
        textColor: const Color.fromARGB(255, 7, 7, 7),
        padding: const EdgeInsets.all(20),
        onPressed: () {
          updateData();
        },
        child: const Text('Update'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/softtouch.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: FormBuilder(
              key: _formKey,
              initialValue: {
                'name': widget.user.name,
                'email': widget.user.email,
                'customerfeedback': widget.user.customerfeedback,
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
                    name: 'customerfeedback',
                    decoration:
                        const InputDecoration(labelText: 'Customerfeedback'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
