
class CreateProductRequest {
  final String nome;
  final double price;
  final String categoryId;
  final DateTime createdDate = DateTime.now();

   CreateProductRequest({required this.nome, required this.price, required this.categoryId});

  

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nome': nome,
      'price': price,
      'categoryId': categoryId,
      'createdDate': createdDate.toIso8601String(),

    };
  }
}
