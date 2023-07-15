class UserModel {
  String fullName; // Emri i plotë i përdoruesit
  String id; // ID e përdoruesit
  String email; // Email-i i përdoruesit
  String password; // Fjalëkalimi i përdoruesit
  String phoneNumber; // Numri i telefonit i përdoruesit

  UserModel({
    required this.fullName,
    required this.id,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'], // Marrja e emrit të plotë nga JSON-i
      id: json['id'], // Marrja e ID-së nga JSON-i
      email: json['email'], // Marrja e email-it nga JSON-i
      password: json['password'], // Marrja e fjalëkalimit nga JSON-i
      phoneNumber:
          json['phoneNumber'], // Marrja e numrit të telefonit nga JSON-i
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName, // Kthimi i emrit të plotë në JSON
      'id': id, // Kthimi i ID-së në JSON
      'email': email, // Kthimi i email-it në JSON
      'password': password, // Kthimi i fjalëkalimit në JSON
      'phoneNumber': phoneNumber, // Kthimi i numrit të telefonit në JSON
    };
  }
}
