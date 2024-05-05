import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int completedPickups = 0, pendingPickups = 0;

  @override
  void initState() {
    super.initState();
    fetchCompletedPickups();
    fetchPendingPickups();
  }

  Future<int> getCompletedPickupCount() async{
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('pickups').where('status', isEqualTo: 'Completed').get();
      final int completedCount = querySnapshot.size;
      return completedCount;
      // print('Completed Pickups Count: $completedCount');
    }catch (error){
      print('Error fetching completed pickups: $error');
      rethrow;
    }
  }

  Future<void> fetchCompletedPickups() async {
    try {
      final int count = await getCompletedPickupCount();
      setState(() {
        completedPickups = count;
      });
    } catch (error) {
      print('Error fetching completed pickups: $error');
    }
  }

  Future<int> getPendingPickupCount() async {
    try{
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('pickups').where('status', isEqualTo: 'Pending').get();
      final int pendingCount = querySnapshot.size;
      return pendingCount;
    }catch (error){
      print('Error fetching pending pickups: $error');
      rethrow;
    }
  }

  Future<void> fetchPendingPickups() async {
    try{
      final int count = await getPendingPickupCount();
      setState(() {
        pendingPickups = count;
      });
    }catch (error){
      print('Error fetching pending pickups: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
          child: Text(
            'Hello, Nayan!',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.png'),
                    radius: 35.0,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'Nayan Raut \nnayanraut1412@gmail.com',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 20.0),
                  child: Container(
                    width: 150.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 20.0),
                              child: Image.asset(
                                'assets/images/Verification.png',
                                width: 80,
                                height: 80,
                              )),
                        ),
                        Expanded(
                          child: Text(
                            '$completedPickups',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/complete_pickup');
                              },
                              child: const Text(
                                'Completed Pickups',
                                textAlign: TextAlign.center,
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.green),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 05.0, vertical: 05.0),
                  child: Container(
                    width: 150.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                            child: Image.asset('assets/images/Expired.png'),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '$pendingPickups',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/pending_pickup');
                              },
                              child: const Text(
                                'Pending Pickups',
                                textAlign: TextAlign.center,
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.green),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  'assets/images/pickupboy.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Container(
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
            currentIndex: 0,
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, '/home');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/notifications');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/settings');
                  break;
              }
            },
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.green,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.0),
            border: Border.all(color: Colors.black),
          ),
        ),
      ),
    );
  }
}