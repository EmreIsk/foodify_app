class CrudCevap {
  int success;
  String message;

  CrudCevap({required this.success, required this.message});

  factory CrudCevap.fromJson(Map<String, dynamic> json) {
    return CrudCevap(
      success: json['success'] as int,
      message: json['message'] as String,
    );
  }
}