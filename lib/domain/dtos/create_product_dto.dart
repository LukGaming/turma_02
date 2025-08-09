class CreateProductDto {
  final String name;
  final double price;
  final String categoryId;

  const CreateProductDto({
    required this.name,
    required this.price,
    required this.categoryId,
  });
}
