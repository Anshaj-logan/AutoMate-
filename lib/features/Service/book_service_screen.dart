import 'package:auto_mate/core/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_mate/core/database/db_helper.dart';

import 'package:auto_mate/core/models/vehicle_model.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({super.key});

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  List<Vehicle> _vehicles = [];
  Vehicle? _selectedVehicle;
  String? _selectedService;
  String? _selectedTimeSlot;

  final List<String> _services = ['Oil Change', 'General Service', 'Tire Rotation'];
  final List<String> _timeSlots = ['10:00 AM', '12:00 PM', '2:00 PM', '4:00 PM'];

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

  void _confirmBooking() async {
    if (_selectedVehicle == null || _selectedService == null || _selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all selections.")),
      );
      return;
    }

    final booking = ServiceBooking(
      vehicleId: _selectedVehicle!.id!,
      serviceType: _selectedService!,
      timeSlot: _selectedTimeSlot!,
      status: "Completed",
    );

    await DBHelper.insertService(booking);

    if (mounted) {
     ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text(
      "Service booked successfully!",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    backgroundColor: Colors.green, 
    behavior: SnackBarBehavior.floating, 
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(16), 
    duration: const Duration(seconds: 3),
  ),
);

      Navigator.pop(context); // Replace with pushNamed if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book a Service")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose your vehicle and service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // --- Card Section for Form ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    DropdownButtonFormField<Vehicle>(
                      value: _selectedVehicle,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: "Select Vehicle",
                        prefixIcon: const Icon(Icons.directions_car),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: _vehicles.map((v) {
                        return DropdownMenuItem(
                          value: v,
                          child: Text("${v.brand} ${v.model} (${v.plateNumber})"),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedVehicle = value),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedService,
                       isExpanded: true,
                      decoration: InputDecoration(
                        labelText: "Select Service",
                        prefixIcon: const Icon(Icons.miscellaneous_services),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: _services.map((s) {
                        return DropdownMenuItem(
                          value: s,
                          child: Text(s),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedService = value),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedTimeSlot,
                       isExpanded: true,
                      decoration: InputDecoration(
                        labelText: "Select Time Slot",
                        prefixIcon: const Icon(Icons.access_time),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: _timeSlots.map((s) {
                        return DropdownMenuItem(
                          value: s,
                          child: Text(s),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedTimeSlot = value),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _confirmBooking,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  "Review & Confirm",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
