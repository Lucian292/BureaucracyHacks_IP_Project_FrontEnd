class User {
  String token;
  String name;
  String surname;
  String username;
  String email;
  String password;
  // ignore: non_constant_identifier_names
  String phone_number;
  // ignore: non_constant_identifier_names
  String created_at;
  String city;
  String roles;

  User(
      {required this.roles,
      required this.token,
      required this.name,
      required this.surname,
      required this.username,
      required this.email,
      required this.password,
      // ignore: non_constant_identifier_names
      required this.phone_number,
      // ignore: non_constant_identifier_names
      required this.created_at,
      required this.city});

  String getUsername() {
    return username;
  }

  String getName() {
    return name;
  }

  String getSurName() {
    return surname;
  }

  String getEmail() {
    return email;
  }

  String getPhone() {
    return phone_number;
  }

  String getCity() {
    return city;
  }

  String getPassword() {
    return password;
  }

  String getToken() {
    return token;
  }

  String getRoles() {
    return roles;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPhone(String phone) {
    phone_number = phone;
  }

  void setToken(String token) {
    this.token = token;
  }

  void setRole(String roles) {
    this.roles = roles;
  }

  void setPassword(String password) {
    this.password = password;
  }
}

late User myUser;
bool isLogged = false;
bool isAdmin = false;
