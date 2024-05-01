import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PendingPickup extends StatelessWidget {
  const PendingPickup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pending Pickup',
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pickups').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<PendingData> pendingDataList = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            final Timestamp datestamp = data['date'];
            DateTime date = datestamp.toDate();

            String time = data['time'] as String;

            return PendingData(
              time: time,
              date: date,
              address: data['location'] ?? '',
            );
          }).toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pendingDataList.length,
                    itemBuilder: (context, index) {
                      return PendingWidget(data: pendingDataList[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PendingData {
  final String time;
  final DateTime date;
  final String address;

  PendingData({
    required this.time,
    required this.date,
    required this.address,
  });
}

class PendingWidget extends StatelessWidget {
  final PendingData data;

  const PendingWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 300,
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Time: ${data.time} \n', // Format time for display
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Date: ${DateFormat('dd MMMM yyyy').format(data.date)} \n', // Format date for display
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Address: ${data.address} \n',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 190,
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.orange[300], // Text color
                      side: const BorderSide(color: Colors.black), // Border color
                      shadowColor: Colors.grey, // Shadow color
                      elevation: 5,
                      // Elevation (controls the intensity of the shadow)
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15), // Border radius
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Open with map',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            'assets/images/google-maps.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}