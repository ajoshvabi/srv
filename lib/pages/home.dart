import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:srv/controller/homecontroller.dart';
import 'package:srv/model/model.dart';
import 'package:srv/model/sidebar.dart';
import 'package:srv/pages/card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiClient api = ApiClient();
  List<Map<String, dynamic>> drawerItems = [];

  @override
  void initState() {
    super.initState();
    fetchDataSidebar().then((sidebarItems) {
      setState(() {
        drawerItems = sidebarItems
            .map((item) => {
                  'icon': Icons.ac_unit,
                  'text': item.englishName,
                })
            .toList();
      });
    });
  }

  Future<List<SidebarItem>> fetchDataSidebar() async {
    // Your API call logic goes here
    return api.fetchDataSidebar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 214, 214, 214),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  const Color.fromARGB(255, 97, 226, 255).withOpacity(0.6),
                  const Color.fromARGB(255, 152, 245, 255).withOpacity(0.6),
                  const Color.fromARGB(255, 62, 255, 249).withOpacity(0.6),
                  const Color.fromARGB(255, 139, 255, 247).withOpacity(0.6),
                ],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "COMMUNITY",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "SKILL PARK",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const FaIcon(FontAwesomeIcons.barsStaggered),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.bell),
            )
          ],
        ),
        drawer: drawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  const Color.fromARGB(255, 97, 226, 255).withOpacity(0.6),
                  const Color.fromARGB(255, 152, 245, 255).withOpacity(0.6),
                  const Color.fromARGB(255, 62, 255, 249).withOpacity(0.6),
                  const Color.fromARGB(255, 139, 255, 247).withOpacity(0.6),
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        fillColor: Colors.white,
                        hintText: "Search...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder<List<Batch>>(
                    future: api.fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        log("1");
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.80,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      } else if (snapshot.hasError) {
                        log("2");
                        return Text('Error: ${snapshot.error}');
                      } else {
                        log("3");
                        if (snapshot.data == null) {
                          log("Data is null");
                          return const Text("No data available");
                        }
                        final batches = snapshot.data!;
                        if (batches.isEmpty) {
                          log("Empty data");
                          return const Text("No data available");
                        }
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.only(bottom: 200),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: batches.length,
                            itemBuilder: (context, index) {
                              final batch = batches[index];
                              return card(context, batch);
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.redAccent,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.stacked_bar_chart_outlined,
                  color: Colors.black,
                ),
                label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.report,
                  color: Colors.black,
                ),
                label: 'Settings'),
          ],
          // currentIndex: _selectedIndex,
          // onTap: _onItemTapped,
        ));
  }

  Drawer drawer() {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color.fromARGB(255, 97, 226, 255).withOpacity(0.6),
                    const Color.fromARGB(255, 152, 245, 255).withOpacity(0.6),
                    const Color.fromARGB(255, 62, 255, 249).withOpacity(0.6),
                    const Color.fromARGB(255, 139, 255, 247).withOpacity(0.6),
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: <Widget>[
                      const DrawerHeader(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Text(
                          'Hi\nAjosh V Abi',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SafeArea(
                          child: Column(
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: drawerItems.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                            top: index == 0
                                                ? const Radius.circular(30)
                                                : Radius.zero,
                                            bottom:
                                                index == drawerItems.length - 1
                                                    ? const Radius.circular(30)
                                                    : Radius.zero,
                                          ),
                                        ),
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: index == 0
                                                ? const FaIcon(
                                                    FontAwesomeIcons.user,
                                                    color: Colors.blueAccent,
                                                  )
                                                : index == 1
                                                    ? const FaIcon(
                                                        FontAwesomeIcons
                                                            .calendarDay,
                                                        color:
                                                            Colors.blueAccent,
                                                      )
                                                    : index == 2
                                                        ? const FaIcon(
                                                            FontAwesomeIcons
                                                                .graduationCap,
                                                            color: Colors
                                                                .blueAccent,
                                                          )
                                                        : index == 3
                                                            ? const FaIcon(
                                                                FontAwesomeIcons
                                                                    .school,
                                                                color: Colors
                                                                    .blueAccent,
                                                              )
                                                            : const FaIcon(
                                                                FontAwesomeIcons
                                                                    .calendarPlus,
                                                                color: Colors
                                                                    .blueAccent,
                                                              )),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        drawerItems[index]['text'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
