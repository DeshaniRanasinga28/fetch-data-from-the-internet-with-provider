import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/count_provider.dart';
import '../provider/user_provider.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, userData, child) {
            if (userData.user == null) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Fetching user data...'),
                ],
              );
            } else {
              return ListView.builder(
                  itemCount: userData.user?.data.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: w,
                        height: 100.0,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                  userData.user?.data.elementAt(index).avatar ??
                                      ""),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${userData.user?.data.elementAt(index).firstName} ${userData.user?.data.elementAt(index).lastName}"),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      userData.user?.data
                                              .elementAt(index)
                                              .email ??
                                          "",
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
