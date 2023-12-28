class Contact {
  final int? id;
  final String name;
  final int phoneNumber;
  final String email;

  Contact(
      {this.id,
      required this.name,
      required this.phoneNumber,
      required this.email});

  Contact.fromMap(Map<String,	dynamic>	res)
      :	id	=	res["id"],
        name	=	res["name"],
        phoneNumber	=	res["phoneNumber"],
        email	=	res["email"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}
