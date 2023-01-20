class NotificationModel {
  String? picture;
  String? name;
  String? email;
  String?request;
  String?price;
  String? doc;



  NotificationModel({
    this.picture,
    this.name,
    this.email,
    this.doc,
    this.request,
    this.price,

  });

  Map<String, dynamic> toJson() {
    return {
      "picture": this.picture,
      "name": this.name,
      "email": this.email,
      "doc": this.doc,
      "request": this.request,
      "price": this.price,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      picture: json["picture"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      doc: json["doc"] ?? "",
      request: json["request"] ?? "",
      price: json["price"] ?? "",

    );
  }
}
