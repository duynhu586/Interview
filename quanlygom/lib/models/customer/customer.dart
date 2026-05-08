class Customer {
  final String id;
  final String name;
  final String phoneNumber;

  Customer({required this.id, required this.name, required this.phoneNumber});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
