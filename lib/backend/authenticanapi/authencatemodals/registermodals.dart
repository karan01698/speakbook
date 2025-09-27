import 'dart:convert';

class UserModel {
  final String phone;
  final String CPassword;
  final String password;
  final String name;
  final String email;
  final String dob;

  final String token; // Added token parameter

  UserModel({
    required this.phone,
    required this.CPassword,
    required this.password,
    required this.name,
    required this.email,
    required this.dob,
    required this.token, // Required token
  });

  Map<String, String> toJson() {
    return {
      "CPassword": CPassword,
      "Phone": phone,
      "Password": password,
      "Name": name,
      "Email": email,
      "Dob": dob,
      "token": token, // Added token in the JSON body
    };
  }
}

class loginUsers {

  final String email;
  final String password;
  final String token;


  loginUsers({required this.email,  required this.password, required this.token});

  Map<String, String> toJson() {
    return {

      "Email": email.trim(), // ✅ Ensure no spaces
      "Password": password.trim(), // ✅ Ensure no spaces
      "token": token,
    };
  }
}

class forgotPasswordModal {
  final String email;
  final String password;
  final String token;


  forgotPasswordModal({required this.email,  required this.password, required this.token});

  Map<String, String> toJson() {
    return {

      "Email": email.trim(), // ✅ Ensure no spaces
      "NewPassword": password.trim(), // ✅ Ensure no spaces
      "token": token,
    };
  }
}

class WithdrawAmountModal {
  final String token;
  final String tid;
  final String amt;
  final String purpose;
  final String type;
  final String tDate;
  final String accountNumber;
  final String ifsc;
  final String branch;
  final String upi;
  final String phone;
  final String dealer;

  WithdrawAmountModal({
    required this.token,
    required this.tid,
    required this.amt,
    required this.purpose,
    required this.type,
    required this.tDate,
    required this.accountNumber,
    required this.ifsc,
    required this.branch,
    required this.upi,
    required this.phone,
    required this.dealer,
  });

  Map<String, String> toJson() {
    return {
      "token": token,
      "tid": tid,
      "amt": amt,
      "purpose": purpose,
      "type": type,
      "tDate": tDate,
      "accountNumber": accountNumber,
      "ifsc": ifsc,
      "branch": branch,
      "uPi": upi,
      "Phone": phone,
      "dealer": dealer,
    };
  }
}




class UpdateUserModal {
  final String phone;
  final String name;
  final String token; // Added token parameter
  final String email; // Added token parameter
  final String dob; // Added token parameter
  final String images; // Added token parameter

  UpdateUserModal({
    required this.phone,
    required this.name,
    required this.token,
    required this.email,
    required this.dob,
    required this.images,


  });

  Map<String, String> toJson() {
    return {
      "Phone": phone,
      "Name": name,
      "Email":email,
      "token": token, // Added token in the JSON body
      "Images": images, // Added token in the JSON body
      "Dob": dob, // Added token in the JSON body
    };
  }
}
class InsertbetUserModal {
  final String token;
  final String game;
  final String money;
  final String rate;
  final String type;
  final String phone;
  final String bdate;
  final String game2;

  InsertbetUserModal({
    required this.token,
    required this.game,
    required this.money,
    required this.rate,
    required this.type,
    required this.phone,
    required this.bdate,
    required this.game2,
  });

  Map<String, String> toJson() {
    return {
      "Token": token,
      "Game": game,
      "Money": money,
      "Rate": rate,
      "Type": type,
      "Phone": phone,
      "Bdate": bdate,
      "Gamename":game2,
    };
  }
}

class UpdateBalanceModal {
  final String token;
  final String bal;
  final String phone;
  final String add;

  UpdateBalanceModal({
    required this.token,
    required this.bal,
    required this.phone,
    required this.add,
  });

  Map<String, String> toJson() {
    return {
      "Token": token,
      "bal": bal,
      "Phone": phone,
      "operation":add
    };
  }
}










///////////////Getmodals

class UserProfile {
  final int id;
  final String name;
  final String email;
  final String password;
  final String cpassword;
  final String phone;
  final String DOB;
  final String Images;


  UserProfile( {
    required this.id,
    required this.phone,
    required this.password,
    required this. cpassword,
    required this.name,
    required this.email,
    required this.DOB,
    required this.Images

  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"] ?? 0,
      phone: json["Phone"] ?? "",
      password: json["Password"] ?? "",
      cpassword: json["CPassword"] ?? "",
      name: json["Name"] ?? "",
      email: json["Email"] ?? "",
      DOB: json["DOB"] ?? "",
      Images: json["Images"] ?? "",
    );
  }
}
class GetBetProfileModal {
  final String token;
  final String game;
  final String phone;
  final String bal;
  final String bdate;
  final String game2;
  final String rate;
  final String type;


  GetBetProfileModal( {
    required this.token,
    required this.game,
    required this.phone,
    required this.bal,
    required this.bdate,
    required this.rate,
    required this.type,
    required this.game2,


  });

  factory GetBetProfileModal.fromJson(Map<String, dynamic> json) {
    return GetBetProfileModal(
      bal: json["Money"]?? "",
      token: json["token"] ?? "",
      game: json["Game"] ?? "",
      phone: json["Phone"] ?? "",
      bdate: json["BDate"] ?? "",
      game2: json["Gamename"] ?? "",
      type: json["Type"] ?? "",
      rate: json["Rate"] ?? "",
    );
  }
}


class QRModel {
  int id;
  String qr1;
  String upi;
  String dealer;

  QRModel({required this.id, required this.qr1, required this.upi,required this.dealer});

  factory QRModel.fromJson(Map<String, dynamic> json) {
    return QRModel(
      id: json['id'],
      qr1: json['QR'],
      upi: json['UPI'],
      dealer: json['Dealer'],
    );
  }

  static List<QRModel> fromJsonList(String str) {
    final jsonData = jsonDecode(str);
    return List<QRModel>.from(jsonData.map((x) => QRModel.fromJson(x)));
  }
}

class Transaction {
  int id;
  String transactionID;
  String transactionAmt;
  String transactionPurpose;
  String transactionType;
  String tDate;
  String accountNumber;
  String ifsc;
  String branch;
  String phone;

  Transaction({
    required this.id,
    required this.transactionID,
    required this.transactionAmt,
    required this.transactionPurpose,
    required this.transactionType,
    required this.tDate,
    required this.accountNumber,
    required this.ifsc,
    required this.branch,
    required this.phone,
  });

  // Factory method to create a Transaction object from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      transactionID: json['TransactionID'],
      transactionAmt: json['TransactionAmt'],
      transactionPurpose: json['TransactionPurpose'],
      transactionType: json['TransactionType'],
      tDate: json['TDate'],
      accountNumber: json['Accountnumber'],
      ifsc: json['IFSC'],
      branch: json['Branch'],
      phone: json['Phone'],
    );
  }

  // Method to convert Transaction object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'TransactionID': transactionID,
      'TransactionAmt': transactionAmt,
      'TransactionPurpose': transactionPurpose,
      'TransactionType': transactionType,
      'TDate': tDate,
      'Accountnumber': accountNumber,
      'IFSC': ifsc,
      'Branch': branch,
      'Phone': phone,
    };
  }
}


//feedback


