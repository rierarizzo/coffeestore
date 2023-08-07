class GeneralResponse<T> {
  final int status;
  final T body;
  final String issuedAt;
  final String requestID;

  GeneralResponse({
    required this.status,
    required this.body,
    required this.issuedAt,
    required this.requestID,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse<T>(
      status: json['status'],
      body: json['body'],
      issuedAt: json['issuedAt'],
      requestID: json['requestID'],
    );
  }
}
