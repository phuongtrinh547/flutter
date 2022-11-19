class Profile {
  static int id = 0;
  static String username = "";
  static String email = "";
  static String fisrt_name = "";
  static String last_name = "";
  static String phone = "";
  static String avartar = "";
  static String address = "";
  static int role_id = 0;
  Profile();
  factory Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fisrt_name = json['fisrt_name'];
    last_name = json['last_name'];
    phone = json['phone'];
    avartar = json['avartar'];
    address = json['address'];
    role_id = json['role_id'];
    return Profile();
  }
}
