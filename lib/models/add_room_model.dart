class AddRoomModel {
  String? picture;
  String? price;
  String? description;
  String? squreFit;
  String? doc;


  AddRoomModel({
    this.picture,
    this.price,
    this.description,
    this.squreFit,
    this.doc,
  });

  Map<String, dynamic> toJson() {
    return {
      "picture": this.picture,
      "price": this.price,
      "description": this.description,
      "squreFit": this.squreFit,
      "doc": this.doc,
    };
  }

  factory AddRoomModel.fromJson(Map<String, dynamic> json) {
    return AddRoomModel(
      picture: json["picture"] ?? "",
      price: json["price"] ?? "",
      description: json["description"] ?? "",
      squreFit: json["squreFit"] ?? "",
      doc: json["doc"] ?? "",

    );
  }
}
