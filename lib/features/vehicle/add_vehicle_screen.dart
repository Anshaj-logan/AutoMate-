import 'package:auto_mate/core/models/vehicle_model.dart';
import 'package:flutter/material.dart';

import 'package:auto_mate/core/database/db_helper.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();

  final _plateController = TextEditingController();
  final _vinController = TextEditingController();
  final _yearController = TextEditingController();

  String? _selectedBrand;
  String? _selectedModel;

  final Map<String, List<String>> _brandModelMap = {
    'Toyota': ['Corolla', 'Camry', 'Fortuner'],
    'Honda': ['Civic', 'City', 'CR-V'],
    'Hyundai': ['i20', 'Verna', 'Creta'],
  };

  List<String> get _models =>
      _selectedBrand != null ? _brandModelMap[_selectedBrand!] ?? [] : [];

void _saveVehicle() async {
  if (_formKey.currentState!.validate()) {
    final vehicle = Vehicle(
      plateNumber: _plateController.text.trim(),
      vin: _vinController.text.trim(),
      brand: _selectedBrand!,
      model: _selectedModel!,
      year: int.parse(_yearController.text.trim()),
    );

    await DBHelper.insertVehicle(vehicle);

    if (mounted) {
      Navigator.pop(context, true); // Indicate success
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Vehicle")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _plateController,
                decoration: const InputDecoration(
                  labelText: 'Plate Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _vinController,
                decoration: const InputDecoration(
                  labelText: 'VIN',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedBrand,
                decoration: const InputDecoration(
                  labelText: 'Brand',
                  border: OutlineInputBorder(),
                ),
                items: _brandModelMap.keys
                    .map((brand) => DropdownMenuItem(
                          value: brand,
                          child: Text(brand),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBrand = value;
                    _selectedModel = null;
                  });
                },
                validator: (value) => value == null ? 'Select brand' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedModel,
                decoration: const InputDecoration(
                  labelText: 'Model',
                  border: OutlineInputBorder(),
                ),
                items: _models
                    .map((model) => DropdownMenuItem(
                          value: model,
                          child: Text(model),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedModel = value),
                validator: (value) => value == null ? 'Select model' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  final year = int.tryParse(value);
                  if (year == null || year < 1990 || year > DateTime.now().year) {
                    return 'Enter valid year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveVehicle,
                child: const Text("Save Vehicle"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
