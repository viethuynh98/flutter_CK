class UserModel {
  String? username;
  String? password;

  UserModel();

  // data type của value là không xác định trước nên là dynamic
  // data type của key là string
  // Name constructor: đối tượng có 3 field bên dưới
  UserModel.fromJson(Map<String, dynamic> json) { // set
    username = json['username'];
    password = json['password'];
  }

  // từ Object trả về 1 Map
  Map<String, dynamic> toJson() { // get: lấy giá trị lưu thành 1 Map.
    return {
      'username': username,
      'password': password,
    };
  }
}
