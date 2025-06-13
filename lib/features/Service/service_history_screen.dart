import 'package:auto_mate/core/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_mate/core/database/db_helper.dart';

import 'package:auto_mate/core/models/vehicle_model.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  List<ServiceBooking> _bookings = [];
  Map<int, Vehicle> _vehicleMap = {};
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadServiceHistory();
  }

Future<void> _loadServiceHistory() async {
  final bookings = await DBHelper.getCompletedBookings();
  final vehicles = await DBHelper.getAllVehicles();

  final vehicleMap = {
    for (var v in vehicles) v.id!: v,
  };

  setState(() {
    _bookings = bookings;
    _vehicleMap = vehicleMap;
    _isLoading = false;
  });
}


 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Service History")),
    body: _isLoading
        ? const Center(child: CircularProgressIndicator()) 
        : _bookings.isEmpty
            ? const Center(child: Text("No completed services yet."))
            : ListView.builder(
                itemCount: _bookings.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final booking = _bookings[index];
                  final vehicle = _vehicleMap[booking.vehicleId];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.check_circle, color: Colors.green),
                      title: Text(booking.serviceType),
                      subtitle: Text(
                        vehicle != null
                            ? "${vehicle.brand} ${vehicle.model} (${vehicle.plateNumber})"
                            : "Vehicle ID: ${booking.vehicleId}",
                      ),
                      trailing: Text(booking.timeSlot),
                    ),
                  );
                },
              ),
  );
}

}
