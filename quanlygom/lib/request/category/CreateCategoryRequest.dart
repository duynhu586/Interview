class CreateCategoryRequest {
  final String name;
  final String? description;

  CreateCategoryRequest({required this.name, this.description});

  Map<String, dynamic> toJson() => {"name": name, "description": description};
}
