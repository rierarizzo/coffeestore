class PaymentCard {
  int id;
  String type;
  int company;
  String holderName;
  String number;
  int expirationYear;
  int expirationMonth;
  String cvv;

  PaymentCard({
    required this.id,
    required this.type,
    required this.company,
    required this.holderName,
    required this.number,
    required this.expirationYear,
    required this.expirationMonth,
    required this.cvv,
  });
}
