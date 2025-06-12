class ServiceBooking {
  final int? id;
  final int vehicleId;
  final String serviceType;
  final String timeSlot;
  final String status;

  ServiceBooking({
    this.id,
    required this.vehicleId,
    required this.serviceType,
    required this.timeSlot,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'serviceType': serviceType,
      'timeSlot': timeSlot,
      'status': status,
    };
  }

  factory ServiceBooking.fromMap(Map<String, dynamic> map) {
    return ServiceBooking(
      id: map['id'],
      vehicleId: map['vehicleId'],
      serviceType: map['serviceType'],
      timeSlot: map['timeSlot'],
      status: map['status'],
    );
  }
}
