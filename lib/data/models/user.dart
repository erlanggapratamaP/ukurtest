class User {
  String? id;
  bool? isActive;
  Profile? profile;
  String? company;
  String? about;
  String? registered;

  User(
      {this.id,
      this.isActive,
      this.profile,
      this.company,
      this.about,
      this.registered});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    company = json['company'];
    about = json['about'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['isActive'] = isActive;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['company'] = company;
    data['about'] = about;
    data['registered'] = registered;
    return data;
  }
}

class Profile {
  String? picture;
  int? age;
  String? eyeColor;
  String? name;
  String? gender;
  String? email;
  String? phone;
  String? address;

  Profile(
      {this.picture,
      this.age,
      this.eyeColor,
      this.name,
      this.gender,
      this.email,
      this.phone,
      this.address});

  Profile.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
    age = json['age'];
    eyeColor = json['eyeColor'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picture'] = picture;
    data['age'] = age;
    data['eyeColor'] = eyeColor;
    data['name'] = name;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}
