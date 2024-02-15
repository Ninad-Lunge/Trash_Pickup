import 'package:flutter/material.dart';

class PendingPickup extends StatelessWidget {
  const PendingPickup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                child: Text(
                  'Pending Pickup',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  ),
                ),
              ),
              SizedBox(height: 10),
              PendingWidget(
                  name: 'Nayan Raut',
                  address: 'Karla Road \n Wardha',
                  date: '1070'),
              PendingWidget(
                  name: 'Shrawani Gulkari',
                  address: 'New Road \n Wardha',
                  date: '1070'),
            ],
          ),
        ),
      ),
    );
  }
}

class PendingWidget extends StatelessWidget {
  final String name, address, date;

  const PendingWidget(
      {Key? key, required this.name, required this.address, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 1), // Stroke
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 300,
                height: 10,
              ),
              Text(
                '$name \n\n Address:  $address \n\n Pickup Date: $date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                  height:
                      10), // Add some space between text and the new container
              Container(
                width: 150, // Set the width as needed
                height: 50, // Set the height as needed
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 1), // Stroke
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Additional Info', // Add your text here
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.info, // Add your icon here
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomBottomNavigationBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const CustomBottomNavigationBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//       child: Container(
//         child: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu),
//               label: 'Menu',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.message_outlined),
//               label: 'Notification',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings_outlined),
//               label: 'Settings',
//             ),
//           ],
//           currentIndex: currentIndex,
//           onTap: onTap,
//           elevation: 0.0,
//           backgroundColor: Colors.transparent,
//           selectedItemColor: Colors.green,
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(17.0),
//           border: Border.all(color: Colors.black),
//         ),
//       ),
//     );
//   }
// }
