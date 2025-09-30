// data/models/delivery/delivery_info.dart
class DeliveryInfo {
  final String recipientName;
  final String phoneNumber;
  final String address;
  final double? latitude;
  final double? longitude;
  final bool payWithCard;
  final String? cardNumber;
  final String? cardName;
  final String? cvc;

  DeliveryInfo({
    required this.recipientName,
    required this.phoneNumber,
    required this.address,
    this.latitude,
    this.longitude,
    required this.payWithCard,
    this.cardNumber,
    this.cardName,
    this.cvc,
  });

  Map<String, dynamic> toMap() => {
    'recipientName': recipientName,
    'phoneNumber': phoneNumber,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'payWithCard': payWithCard,
    'cardNumber': cardNumber,
    'cardName': cardName,
    'cvc': cvc,
  };
}
