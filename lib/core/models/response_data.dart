class ResponseData {
  const ResponseData({
    required this.isSuccess,
    required this.statusCode,
    required this.responseData,
    required this.errorMessage,
  });

  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String errorMessage;

  bool get hasError => !isSuccess;

  Map<String, dynamic> get dataAsMap {
    final data = responseData;
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    return <String, dynamic>{};
  }

  @override
  String toString() {
    return 'ResponseData('
        'isSuccess: $isSuccess, '
        'statusCode: $statusCode, '
        'errorMessage: $errorMessage'
        ')';
  }
}
