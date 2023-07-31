import 'package:coffee_store/entities/paymentcard.dart';
import 'package:coffee_store/entities/address.dart';

class User {
  int? id;
  String username;
  String name;
  String surname;
  String? phoneNumber;
  String email;
  String password;
  String roleCode;
  List<Address>? addresses;
  List<PaymentCard>? paymentCards;

  User({
    this.id,
    required this.username,
    required this.name,
    required this.surname,
    this.phoneNumber,
    required this.email,
    required this.password,
    required this.roleCode,
    this.addresses,
    this.paymentCards,
  });
}
