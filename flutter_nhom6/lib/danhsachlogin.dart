class LoginList {
    int id;
    String firstName;
    String lastName;
    String maidenName;
    int age;
    String gender;
    String email;
    String phone;
    String username;
    String password;
    String birthDate;
    String image;
    String bloodGroup;
    double height;
    double weight;
    String eyeColor;
    Hair hair;
    String ip;
    Address address;
    String macAddress;
    String university;
    Bank bank;
    Company company;
    String ein;
    String ssn;
    String userAgent;
    Crypto crypto;
    String role;

    LoginList({
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
        required this.ip,
        required this.address,
        required this.macAddress,
        required this.university,
        required this.bank,
        required this.company,
        required this.ein,
        required this.ssn,
        required this.userAgent,
        required this.crypto,
        required this.role,
    });

}

class Address {
    String address;
    String city;
    String state;
    String stateCode;
    String postalCode;
    Coordinates coordinates;
    String country;

    Address({
        required this.address,
        required this.city,
        required this.state,
        required this.stateCode,
        required this.postalCode,
        required this.coordinates,
        required this.country,
    });

}

class Coordinates {
    double lat;
    double lng;

    Coordinates({
        required this.lat,
        required this.lng,
    });

}

class Bank {
    String cardExpire;
    String cardNumber;
    String cardType;
    String currency;
    String iban;

    Bank({
        required this.cardExpire,
        required this.cardNumber,
        required this.cardType,
        required this.currency,
        required this.iban,
    });

}

class Company {
    String department;
    String name;
    String title;
    Address address;

    Company({
        required this.department,
        required this.name,
        required this.title,
        required this.address,
    });

}

class Crypto {
    String coin;
    String wallet;
    String network;

    Crypto({
        required this.coin,
        required this.wallet,
        required this.network,
    });

}

class Hair {
    String color;
    String type;

    Hair({
        required this.color,
        required this.type,
    });

}
