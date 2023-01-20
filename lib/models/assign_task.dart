class asignTaskModel {

  String? name;
  String? email;
  String? doc;
  String? task;


  asignTaskModel({

    this.name,
    this.email,
    this.doc,
    this.task,
  });

  Map<String, dynamic> toJson() {
    return {

      "name": this.name,
      "email": this.email,
      "doc": this.doc,
      "task": this.task,
    };
  }

  factory asignTaskModel.fromJson(Map<String, dynamic> json) {
    return asignTaskModel(

      name: json["name"] ?? "",
      email: json["email"] ?? "",

      doc: json["doc"] ?? "",
      task: json["task"] ?? "",
    );
  }
}
