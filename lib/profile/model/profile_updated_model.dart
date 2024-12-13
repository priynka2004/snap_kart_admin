// class ProfileUpdated {
//   String? mobile;
//   String? dob;
//
//   ProfileUpdated({this.mobile, this.dob});
//
//   ProfileUpdated.fromJson(Map<String, dynamic> json) {
//     mobile = json['mobile'];
//     dob = json['dob'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['mobile'] = this.mobile;
//     data['dob'] = this.dob;
//     return data;
//   }
// }

class ProfileUpdated {
  String? sId;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? mobile;
  String? dob;

  ProfileUpdated(
      {this.sId,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.mobile,
        this.dob});

  ProfileUpdated.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    mobile = json['mobile'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    return data;
  }
}