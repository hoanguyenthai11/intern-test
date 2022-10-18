class Shoes {
  int id;
  String image;
  String name;
  String description;
  double price;
  String color;
  int quantity;
  bool isBought;

  Shoes(
      {required this.id,
      required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.color,
      this.quantity = 0,
      this.isBought = false});

  factory Shoes.fromJson(Map<String, dynamic> json) {
    return Shoes(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'],
      color: json['color'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'color': color,
    };
  }

  Shoes copyWith({
    int? id,
    String? image,
    String? name,
    String? description,
    double? price,
    String? color,
    int? quantity,
  }) {
    return Shoes(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity);
  }

  void update() {
    isBought = !isBought;
  }
}


// "id": 1,
//       "image": "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-mens-running-shoe-wide-D24Mcz-removebg-preview.png",
//       "name": "Nike Air Zoom Pegasus 36",
//       "description": "The iconic Nike Air Zoom Pegasus 36 offers more cooling and mesh that targets breathability across high-heat areas. A slimmer heel collar and tongue reduce bulk, while exposed cables give you a snug fit at higher speeds.",
//       "price": 108.97,
//       "color": "#e1e7ed"