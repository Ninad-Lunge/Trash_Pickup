import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'item_details.dart';

class CompletePickup extends StatelessWidget {
  const CompletePickup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Completed Pickup',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  ),
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('pickups').where('status', isEqualTo: 'Completed').snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final List<CompletedData> completedDataList = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;

                    final Timestamp datestamp = data['date'];
                    DateTime date = datestamp.toDate();

                    // String time = data['time'] as String;

                    return CompletedData(
                      totalCost: data['totalCost'],
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
                            itemCount: completedDataList.length,
                            itemBuilder: (context, index) {
                              final docId = snapshot.data!.docs[index].id;
                              print('${docId}\n');
                              return CompletedWidget(data: completedDataList[index], docId: docId);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompletedData {
  final num totalCost;
  final DateTime date;
  final String address;

  CompletedData({
    required this.totalCost,
    required this.date,
    required this.address,
  });
}

class CompletedWidget extends StatelessWidget {
  final CompletedData data;
  final String docId;

  const CompletedWidget({super.key, required this.data, required this.docId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PickupDetailPage(data: data),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(width: 20, height: 55,),
                  Image.asset('assets/images/checkmark.png'),
                  Text(
                    '   ${data.date} \n   Rs ${data.totalCost} ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Expanded(child: SizedBox(width: double.infinity)),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.green,
                      size: 40,
                    ),
                    onPressed: () {
                      // Add navigation or further action here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickupDetailPage(data: data),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
