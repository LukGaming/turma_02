class ProductApiModel {
  final String id;
  final String nome;
  final double price;
  final String categoryId;
  final DateTime createdDate;

  const ProductApiModel({required this.id, required this.nome, required this.createdDate, required this.categoryId, required this.price}); 

  factory ProductApiModel.fromJson(Map<String, dynamic> json){
    return ProductApiModel(id: json['id'], nome: json['nome'], createdDate: DateTime.parse(json['createdDate']), categoryId: json['category'], price: json['price']);
  }
}