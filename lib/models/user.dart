class User {
  final String id;
  final String name;
  final String gender;
  final String dob;
  final String emailaddress;
  final String mobilenumber;
  final String status;
  final int age;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.dob,
    required this.emailaddress,
    required this.mobilenumber,
    required this.status,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      dob: json['dob'],
      emailaddress: json['emailaddress'],
      mobilenumber: json['mobilenumber'],
      status: json['status'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'dob': dob,
      'emailaddress': emailaddress,
      'mobilenumber': mobilenumber,
      'status': status,
      'age': age,
    };
  }
}
