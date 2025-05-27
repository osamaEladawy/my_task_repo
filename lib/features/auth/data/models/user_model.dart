import 'package:my_task_products/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.domain,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
  }) : super(
         id: id,
         firstName: firstName,
         lastName: lastName,
         maidenName: maidenName,
         age: age,
         gender: gender,
         email: email,
         phone: phone,
         username: username,
         password: password,
         birthDate: birthDate,
         image: image,
       );

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final String? age;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final dynamic height;
  final dynamic weight;
  final String? eyeColor;
  final Hair? hair;
  final String? domain;
  final String? ip;
  final Address? address;
  final String? macAddress;
  final String? university;
  final Bank? bank;
  final Company? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      maidenName: json["maidenName"],
      age: json["age"],
      gender: json["gender"],
      email: json["email"],
      phone: json["phone"],
      username: json["username"],
      password: json["password"],
      birthDate: json["birthDate"],
      image: json["image"],
      bloodGroup: json["bloodGroup"],
      height: json["height"],
      weight: json["weight"],
      eyeColor: json["eyeColor"],
      hair: json["hair"] == null ? null : Hair.fromJson(json["hair"]),
      domain: json["domain"],
      ip: json["ip"],
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      macAddress: json["macAddress"],
      university: json["university"],
      bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
      company:
          json["company"] == null ? null : Company.fromJson(json["company"]),
      ein: json["ein"],
      ssn: json["ssn"],
      userAgent: json["userAgent"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "maidenName": maidenName,
    "age": age,
    "gender": gender,
    "email": email,
    "phone": phone,
    "username": username,
    "password": password,
    "birthDate": birthDate,
    "image": image,
    "bloodGroup": bloodGroup,
    "height": height,
    "weight": weight,
    "eyeColor": eyeColor,
    "hair": hair?.toJson(),
    "domain": domain,
    "ip": ip,
    "address": address?.toJson(),
    "macAddress": macAddress,
    "university": university,
    "bank": bank?.toJson(),
    "company": company?.toJson(),
    "ein": ein,
    "ssn": ssn,
    "userAgent": userAgent,
  };

  @override
  String toString() {
    return "$id, $firstName, $lastName, $maidenName, $age, $gender, $email, $phone, $username, $password, $birthDate, $image, $bloodGroup, $height, $weight, $eyeColor, $hair, $domain, $ip, $address, $macAddress, $university, $bank, $company, $ein, $ssn, $userAgent, ";
  }
}

class Address {
  Address({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.postalCode,
    required this.state,
  });

  final String? address;
  final String? city;
  final Coordinates? coordinates;
  final String? postalCode;
  final String? state;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json["address"],
      city: json["city"],
      coordinates:
          json["coordinates"] == null
              ? null
              : Coordinates.fromJson(json["coordinates"]),
      postalCode: json["postalCode"],
      state: json["state"],
    );
  }

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "coordinates": coordinates?.toJson(),
    "postalCode": postalCode,
    "state": state,
  };

  @override
  String toString() {
    return "$address, $city, $coordinates, $postalCode, $state, ";
  }
}

class Coordinates {
  Coordinates({required this.lat, required this.lng});

  final dynamic lat;
  final dynamic lng;

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(lat: json["lat"], lng: json["lng"]);
  }

  Map<String, dynamic> toJson() => {"lat": lat, "lng": lng};

  @override
  String toString() {
    return "$lat, $lng, ";
  }
}

class Bank {
  Bank({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      cardExpire: json["cardExpire"],
      cardNumber: json["cardNumber"],
      cardType: json["cardType"],
      currency: json["currency"],
      iban: json["iban"],
    );
  }

  Map<String, dynamic> toJson() => {
    "cardExpire": cardExpire,
    "cardNumber": cardNumber,
    "cardType": cardType,
    "currency": currency,
    "iban": iban,
  };

  @override
  String toString() {
    return "$cardExpire, $cardNumber, $cardType, $currency, $iban, ";
  }
}

class Company {
  Company({
    required this.address,
    required this.department,
    required this.name,
    required this.title,
  });

  final Address? address;
  final String? department;
  final String? name;
  final String? title;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      department: json["department"],
      name: json["name"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
    "address": address?.toJson(),
    "department": department,
    "name": name,
    "title": title,
  };

  @override
  String toString() {
    return "$address, $department, $name, $title, ";
  }
}

class Hair {
  Hair({required this.color, required this.type});

  final String? color;
  final String? type;

  factory Hair.fromJson(Map<String, dynamic> json) {
    return Hair(color: json["color"], type: json["type"]);
  }

  Map<String, dynamic> toJson() => {"color": color, "type": type};

  @override
  String toString() {
    return "$color, $type, ";
  }
}
