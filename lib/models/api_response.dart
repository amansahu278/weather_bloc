class ApiResponse<T>{
  bool error;
  String errorMessage;
  T data;
  ApiResponse({this.error, this.errorMessage="", this.data=null});
}