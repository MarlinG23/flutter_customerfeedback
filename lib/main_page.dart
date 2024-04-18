import 'package:flutter/material.dart';
import 'package:flutter_customerfeedback_api/add_user.dart';
import 'package:flutter_customerfeedback_api/api_handler.dart';
import 'package:flutter_customerfeedback_api/edit_page.dart';
import 'package:flutter_customerfeedback_api/find_user.dart';
import 'package:flutter_customerfeedback_api/model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ApiHandler apiHandler = ApiHandler();
  late List<User> data = [];

  void getData() async {
    data = await apiHandler.getUserData();
    setState(() {});
  }

  void deleteUser(int userId) async {
    await apiHandler.deleteUser(
      userId: userId,
      onSuccess: () {
        // Refresh data after successful deletion
        getData();
      },
      onError: () {
        // Handle error here
      },
    );
  }

  void _onUserUpdated() {
    getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Feedback"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 187, 239, 248),
        foregroundColor: const Color.fromARGB(255, 7, 7, 7),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/CapeGlobe.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPage(
                                user: data[index], onUpdate: _onUserUpdated),
                          ),
                        );
                      },
                      leading: Text("${data[index].userId}"),
                      title: Text(data[index].name),
                      subtitle: Text(data[index].email),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          deleteUser(data[index].userId);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 187, 239, 248),
        height: 50, // You can adjust the height as needed
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            backgroundColor: const Color.fromARGB(255, 187, 239, 248),
            foregroundColor: const Color.fromARGB(255, 7, 7, 7),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const FindUser()),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 2,
            backgroundColor: const Color.fromARGB(255, 187, 239, 248),
            foregroundColor: const Color.fromARGB(255, 7, 7, 7),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUser(
                      onUserAdded: getData), // Pass getData as the callback
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
