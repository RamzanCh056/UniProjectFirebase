class AddFoodModel {
  String? picture;
  String? price;
  String? description;
  String? name;
  String? doc;


  AddFoodModel({
    this.picture,
    this.price,
    this.description,
    this.name,
    this.doc,
  });

  Map<String, dynamic> toJson() {
    return {
      "picture": this.picture,
      "price": this.price,
      "description": this.description,
      "name": this.name,
      "doc": this.doc,
    };
  }

  factory AddFoodModel.fromJson(Map<String, dynamic> json) {
    return AddFoodModel(
      picture: json["picture"] ?? "",
      price: json["price"] ?? "",
      description: json["description"] ?? "",
      name: json["name"] ?? "",
      doc: json["doc"] ?? "",

    );
  }
}
