class SuplierModel {

  String? name;
  String? email;
  String? doc;
  String? password;
  String? salery;


  SuplierModel({

    this.name,
    this.email,
    this.doc,
    this.password,
    this.salery,
  });

  Map<String, dynamic> toJson() {
    return {

      "name": this.name,
      "email": this.email,
      "doc": this.doc,
      "password": this.password,
      "salery": this.salery,
    };
  }

  factory SuplierModel.fromJson(Map<String, dynamic> json) {
    return SuplierModel(

      name: json["name"] ?? "",
      email: json["email"] ?? "",

      doc: json["doc"] ?? "",
      password: json["password"] ?? "",
      salery: json["salery"] ?? "",
    );
  }
}
