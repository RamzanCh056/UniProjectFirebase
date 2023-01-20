class AddCarModel {
  String? picture;
  String? price;
  String? description;
  String? name;
  String? doc;


  AddCarModel({
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

  factory AddCarModel.fromJson(Map<String, dynamic> json) {
    return AddCarModel(
      picture: json["picture"] ?? "",
      price: json["price"] ?? "",
      description: json["description"] ?? "",
      name: json["name"] ?? "",
      doc: json["doc"] ?? "",

    );
  }
}
