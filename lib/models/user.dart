class User {
  String fullname;
  String email;
  String phone;
  String country;
  String state;
  String username;
  String dob;
  String createdAt;

  User(
      {this.fullname,
      this.email,
      this.phone,
      this.country,
      this.state,
      this.username,
      this.dob,
      this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['Fullname'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    state = json['state'];
    username = json['username'];
    dob = json['dob'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['state'] = this.state;
    data['username'] = this.username;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    return data;
  }
}
