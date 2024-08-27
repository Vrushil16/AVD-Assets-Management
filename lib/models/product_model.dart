class Product {
  final String name;
  final double price;
  final String owner;
  final String location;
  final List<String> imagePaths;

  Product({
    required this.name,
    required this.price,
    required this.owner,
    required this.location,
    required this.imagePaths,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'owner': owner,
      'location': location,
      'imagePaths': imagePaths,
    };
  }
}
