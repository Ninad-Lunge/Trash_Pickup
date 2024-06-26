import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  final List<String> notificationData = const [
    'New delivery assigned. Head to the pickup location.',
    'System update: New feature added for better navigation.',
    'Customer feedback received. Check your ratings and comments.',
    'Reminder: You have upcoming deliveries scheduled for tomorrow.',
    'Go Green'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              const SizedBox(height: 10),
              for (String data in notificationData)
                NotificationWidget(data: data),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              // Do nothing, already on the notifications page
              break;
            case 2:
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final String data;

  const NotificationWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 1),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      '$data',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.green,
                  size: 25,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          currentIndex: currentIndex,
          onTap: onTap,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.green,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          border: Border.all(color: Colors.black),
        ),
      ),
    );
  }
}
