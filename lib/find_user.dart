// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_customerfeedback_api/api_handler.dart';
import 'package:flutter_customerfeedback_api/model.dart';

class FindUser extends StatefulWidget {
  const FindUser({super.key});

  @override
  State<FindUser> createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
  ApiHandler apiHandler = ApiHandler();
  User user = const User.empty();
  TextEditingController textEditingController = TextEditingController();

  void findUser(int userId) async {
    try {
      user = await apiHandler.getUserById(userId: userId);
      setState(() {});
    } catch (e) {
      // Handle exception when user ID does not exist
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('User ID not found'),
            content: const Text('The provided user ID does not exist.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find User"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 187, 239, 248),
        foregroundColor: const Color.fromARGB(255, 7, 7, 7),
      ),
      bottomNavigationBar: MaterialButton(
        color: const Color.fromARGB(255, 187, 239, 248),
        textColor: const Color.fromARGB(255, 7, 7, 7),
        padding: const EdgeInsets.all(20),
        onPressed: () {
          findUser(int.parse(textEditingController.text));
        },
        child: const Text('Find'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/soft1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Text("${user.userId}"),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
