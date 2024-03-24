// ignore_for_file: use_build_context_synchronously

import 'package:craftlocal/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modal/modal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Home'),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_sharp),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: const MyHome(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add your product",
        onPressed: () => Navigator.of(context).pushNamed("/addProducts"),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final List<Map<String, dynamic>> icons = [
    {"icon": const Icon(Icons.home_filled), "label": "Home"},
    {"icon": const Icon(Icons.shopping_cart), "label": "Checkout"},
    {"icon": const Icon(Icons.settings), "label": "Settings"}
  ];

  CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        for (Map<String, dynamic> iconData in icons)
          BottomNavigationBarItem(
            icon: iconData['icon'],
            label: iconData['label'],
          ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final List titles = [
    "Home",
    "Checkout",
    "About",
    "Contact",
    "Delete Account"
  ];
  final List routes = ["/home", "", "", "/contact", ""];

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<CraftLocalProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).highlightColor),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                      child: Text('Abai'),
                    ),
                  ),
                  Text(
                    'Welcome Abaikumar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 54, 54, 54),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (int index = 0; index < titles.length; index++)
            ListTile(
              title: Text(
                titles[index],
              ),
              onTap: () {
                if (index == 4) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Account Deletion'),
                        content: const Text(
                            'Are you sure you want to delete your account? This action cannot be undone.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              String res = await obj.delete();
                              if (res == "Yes") {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => MyLogScreen(),
                                    ),
                                    (route) => false);
                              }
                              // Call the onDeleteConfirmed callback
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(routes[index]);
                }
              },
            )
        ],
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List choices = [];

  Future<void> getDataFromModel(CraftLocalProvider a) async {
    choices = await a.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<CraftLocalProvider>(context, listen: false);

    return FutureBuilder(
      future: getDataFromModel(obj),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: Colors.red,
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            getDataFromModel(obj);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: choices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          'http://127.0.0.1:8000/${choices[index]["image_path"]}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            choices[index]['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Add to cart",
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
