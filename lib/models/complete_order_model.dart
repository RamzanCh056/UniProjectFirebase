class CompleteOrderModel {
  String? name;
  String? email;
  String?request;
  String? task;
  String? doc;



  CompleteOrderModel({
    this.name,
    this.email,
    this.doc,
    this.request,
    this.task,

  });

  Map<String, dynamic> toJson() {
    return {

      "name": this.name,
      "email": this.email,
      "doc": this.doc,
      "request": this.request,
      "task": this.task,
    };
  }

  factory CompleteOrderModel.fromJson(Map<String, dynamic> json) {
    return CompleteOrderModel(

      name: json["name"] ?? "",
      email: json["email"] ?? "",
      doc: json["doc"] ?? "",
      request: json["request"] ?? "",
      task: json["task"] ?? "",

    );
  }
}
