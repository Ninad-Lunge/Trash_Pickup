import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trashpickup/pages/pending_pickup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPickupDetails extends StatefulWidget {
  final PendingData data;
  final String docId;

  const AddPickupDetails({Key? key, required this.data, required this.docId}) : super(key: key);

  @override
  State<AddPickupDetails> createState() => _AddPickupDetailsState();
}

class Item {
  String name;
  double costPerKG;
  double quantity;

  Item(this.name, this.costPerKG, this.quantity);
}

class _AddPickupDetailsState extends State<AddPickupDetails> {
  List<Item> selectedItems = [];
  double totalCost = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Pickup Details',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pickup Details',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Name: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\n ${widget.data.address}\n',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const TextSpan(text: '\n'),
                        const TextSpan(
                          text: 'Date: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                          '${DateFormat('dd MMMM yyyy').format(widget.data.date)} \n',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                child: Text(
                  'Add Items',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField<String>(
                  value: null,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    labelText: "Choose Type Of Item",
                  ),
                  items: <String>[
                    'Newspapers',
                    'Office Papers',
                    'Books',
                    'Plastics',
                    'Steel',
                    'Copper',
                    'Cardboard',
                    'Used Battery',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null &&
                        !selectedItems.any((item) => item.name == newValue)) {
                      setState(() {
                        selectedItems.add(
                          Item(newValue, getCostPerKG(newValue), 0.0),
                        );
                      });
                    }
                  },
                ),
              ),
              if (selectedItems.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: Text(
                    'Selected Items:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              for (int index = 0; index < selectedItems.length; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${selectedItems[index].name}: Rs. ${selectedItems[index].costPerKG} / KG',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (String value) {
                            // Update quantity when the user enters a quantity
                            setState(() {
                              selectedItems[index].quantity =
                                  double.tryParse(value) ?? 0.0;
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide:
                              const BorderSide(color: Colors.green),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide:
                              const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide:
                              const BorderSide(color: Colors.black),
                            ),
                            labelText: "Enter Qty (In KG)",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () {
                          // Remove the selected item when the remove button is pressed
                          setState(() {
                            selectedItems.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              if (selectedItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Calculate total cost when the "Calculate" button is pressed
                      calculateTotalCost();
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Calculate'),
                    ),
                  ),
                ),
                if (totalCost > 0.0)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Total Cost: Rs. $totalCost',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 50,),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    addPickupDetailsToFirestore();
                    print(widget.docId);},
                  child: const Text(
                      'Complete the Pickup',
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getCostPerKG(String itemName) {
    // Function to get cost per KG based on the item name
    switch (itemName) {
      case 'Newspapers':
        return 15.0;
      case 'Office Papers':
        return 20.0;
      case 'Books':
        return 25.0;
      case 'Plastics':
        return 20.0;
      case 'Steel':
        return 25.0;
      case 'Copper':
        return 25.0;
      case 'Cardboard':
        return 20.0;
      case 'Used Battery':
        return 25.0;
      default:
        return 0.0;
    }
  }

  void calculateTotalCost() {
    // Function to calculate total cost of selected items
    totalCost = 0.0;
    for (Item item in selectedItems) {
      totalCost += item.quantity * item.costPerKG;
    }
    setState(() {});
  }

  void addPickupDetailsToFirestore() {
    // Reference to the document to be updated
    final docRef = FirebaseFirestore.instance.collection('pickups').doc(widget.docId);

    // Check if the document exists before updating
    docRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // Document exists, update it
        docRef.update({
          'items': selectedItems
              .map((item) => {
            'name': item.name,
            'costPerKG': item.costPerKG,
            'quantity': item.quantity,
          })
              .toList(),
          'totalCost': totalCost,
          'status': 'Completed', // Change status to Completed
        }).then((_) {
          // Show success pop-up
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Pickup details updated successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop(); // Pop this page
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }).catchError((error) {
          // Handle update errors
          showErrorDialog('Failed to update pickup details: $error');
        });
      } else {
        // Document doesn't exist, handle accordingly
        showErrorDialog('Document does not exist.');
      }
    }).catchError((error) {
      // Handle get document errors
      showErrorDialog('Failed to get document: $error');
    });
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}