class CreateCustomerRequest {
  final String name;
  final String phoneNumber;

  CreateCustomerRequest({required this.name, required this.phoneNumber});

  Map<String, dynamic> toJson() => {"name": name, "phoneNumber": phoneNumber};
}
