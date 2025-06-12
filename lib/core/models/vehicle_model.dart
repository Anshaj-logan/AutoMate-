class Vehicle {
  final int? id;
  final String plateNumber;
  final String vin;
  final String brand;
  final String model;
  final int year;

  Vehicle({
    this.id,
    required this.plateNumber,
    required this.vin,
    required this.brand,
    required this.model,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plateNumber': plateNumber,
      'vin': vin,
      'brand': brand,
      'model': model,
      'year': year,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      plateNumber: map['plateNumber'],
      vin: map['vin'],
      brand: map['brand'],
      model: map['model'],
      year: map['year'],
    );
  }
}
