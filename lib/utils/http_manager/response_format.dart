class ResponseFormat {
  var data;
  bool hasError;
  int statusCode;
  var headers;

  ResponseFormat({this.data, this.hasError, this.statusCode, this.headers});
}