class UpdateCategoryRequest {
  final String id;
  final String name;
  final String? description;

  UpdateCategoryRequest({
    required this.id,
    required this.name,
    this.description,
  });

  Map<String, dynamic> toJson() => {"name": name, "description": description};
}
