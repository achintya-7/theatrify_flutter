class model_sendInfo {
  String emails;
  model_sendInfo({
    required this.emails,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emails'] = this.emails;
    return data;
  }
}
