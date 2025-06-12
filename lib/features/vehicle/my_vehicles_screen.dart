import 'package:auto_mate/core/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_mate/core/database/db_helper.dart';

import 'package:auto_mate/features/vehicle/add_vehicle_screen.dart';

class MyVehiclesScreen extends StatefulWidget {
  const MyVehiclesScreen({super.key});

  @override
  State<MyVehiclesScreen> createState() => _MyVehiclesScreenState();
}

class _MyVehiclesScreenState extends State<MyVehiclesScreen> {
  List<Vehicle> _vehicles = [];

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    final vehicles = await DBHelper.getAllVehicles();
    setState(() {
      _vehicles = vehicles;
    });
  }

  Future<void> _navigateToAddVehicle() async {
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const AddVehicleScreen()),
);

if (result == true) {
  _loadVehicles();
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vehicle added successfully!')),
    );
  }
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Vehicles"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add Vehicle",
            onPressed: _navigateToAddVehicle,
          ),
        ],
      ),
      body: _vehicles.isEmpty
          ? const Center(child: Text("No vehicles added yet."))
          : ListView.builder(
              itemCount: _vehicles.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final v = _vehicles[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.directions_car, color: Colors.blue),
                    title: Text("${v.brand} ${v.model}"),
                    subtitle: Text("Plate: ${v.plateNumber}\nVIN: ${v.vin}"),
                    trailing: Text("${v.year}"),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
