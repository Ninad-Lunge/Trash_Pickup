import 'package:flutter/material.dart';
import 'package:trashpickup/pages/complete_pickup.dart';

class PickupDetailPage extends StatelessWidget {
  // final String date, cost;

  final CompletedData data;

  const PickupDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Item Detail Page',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text('Pickup Date: ${data.date}'),
              //Text('Cost: Rs $cost'),
              const SizedBox(height: 20),
              Invoice(),
            ],
          ),
        ),
      ),
    );
  }
}

class Invoice extends StatelessWidget {
  // final List<String> itemNames = ['Newspapers', 'Steel', 'Cardboard'];
  // final List<int> itemQuantities = [10, 5, 12];
  // final List<double> itemCosts = [15, 37, 15];

  final List<String> itemNames = ['Newspapers', 'Steel', 'Cardboard'];
  final List<int> itemQuantities = [10, 5, 12];
  final List<double> itemCosts = [15, 37, 15];

  @override
  Widget build(BuildContext context) {
    // Calculate total cost and create a list of items with their details
    List<Map<String, dynamic>> items = List.generate(
      itemNames.length,
          (index) {
        double totalItemCost = itemQuantities[index] * itemCosts[index];
        return {
          'name': itemNames[index],
          'quantity': itemQuantities[index],
          'cost': itemCosts[index],
          'totalItemCost': totalItemCost,
        };
      },
    );

    // Calculate the total cost for all items
    double totalCost =
    items.fold(0, (sum, item) => sum + item['totalItemCost']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: DataTable(
            columns: [
              DataColumn(label: Text('   Item')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Cost')),
              //DataColumn(label: Text('Total Cost (Rs)')),
            ],
            rows: List.generate(
              items.length,
                  (index) => DataRow(
                cells: [
                  DataCell(Center(child: Text(items[index]['name']))),
                  DataCell(
                      Center(child: Text(items[index]['quantity'].toString()))),
                  DataCell(
                      Center(child: Text(items[index]['cost'].toString()))),
                  // DataCell(Center(child: Text(items[index]['totalItemCost'].toString()))),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              'Total Cost:   Rs. $totalCost',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Example data
List<Map<String, String>> pickupData = [
  {'date': '02-01-2024', 'cost': '1070'},
  {'date': '25-11-2023', 'cost': '870'},
  {'date': '02-05-2023', 'cost': '515'},
];