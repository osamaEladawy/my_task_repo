class ErrorModel {
  ErrorModel({required this.message});

  final String? message;

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(message: json["message"]);
  }

  Map<String, dynamic> toJson() => {"message": message};

  @override
  String toString() {
    return "$message, ";
  }
}
