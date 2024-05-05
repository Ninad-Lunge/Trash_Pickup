import 'package:flutter/material.dart';
import 'package:trashpickup/pages/pending_pickup.dart';

class MapPage extends StatelessWidget {
  final PendingData data;

  const MapPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can use the data here to display map or any relevant information
    return Scaffold(
      appBar: AppBar(
        title: Text('Map for ${data.address}'),
      ),
      body: Center(
        child: Text('Map will be displayed here for ${data.address}'),
      ),
    );
  }
}