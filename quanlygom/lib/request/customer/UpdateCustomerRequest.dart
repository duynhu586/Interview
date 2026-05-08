class UpdateCustomerRequest {
  final String id;
  final String name;
  final String phoneNumber;

  UpdateCustomerRequest({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {"name": name, "phoneNumber": phoneNumber};
}
