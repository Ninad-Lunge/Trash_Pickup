import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:trashpickup/pages/add_pickup_details.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingPickup extends StatefulWidget {
  const PendingPickup({Key? key}) : super(key: key);

  @override
  State<PendingPickup> createState() => _PendingPickupState();
}

class _PendingPickupState extends State<PendingPickup> {
  // TextEditingController locationController = TextEditingController();
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
        stream: FirebaseFirestore.instance.collection('pickups').where('status', isEqualTo: 'Pending').snapshots(),
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
              latitude: data['latitude'] ?? '',
              longitude: data['longitude'] ?? '',
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
                      final docId = snapshot.data!.docs[index].id; // Retrieve the document ID here
                      print('${docId}\n');
                      return PendingWidget(data: pendingDataList[index], docId: docId); // Pass the document ID here
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
  final String latitude;
  final String longitude;

  PendingData({
    required this.time,
    required this.date,
    required this.address,
    required this.latitude,
    required this.longitude
  });
}

class PendingWidget extends StatefulWidget {
  final PendingData data;
  final String docId;

  const PendingWidget({Key? key, required this.data, required this.docId}) : super(key: key);

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
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
                      text: 'Time: ${widget.data.time} \n', // Format time for display
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Date: ${DateFormat('dd MMMM yyyy').format(widget.data.date)} \n', // Format date for display
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Address: ${widget.data.address} \n',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.orange[300], // Text color
                        side: const BorderSide(color: Colors.black), // Border color
                        shadowColor: Colors.grey, // Shadow color
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        String Latitude = widget.data.latitude;
                        String Longitude = widget.data.longitude;
                        launchUrl(Uri.parse('https://www.google.com/maps?q=$Latitude,$Longitude'));
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
                  IconButton(
                    style: IconButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPickupDetails(data: widget.data, docId: widget.docId),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_box_outlined,
                      color: Colors.lightGreenAccent,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}