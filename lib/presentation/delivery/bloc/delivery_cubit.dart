import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/data/models/delivery_info/delivery_info_model.dart';
import 'package:musicapp/domain/usecases/delivery/process_delivery_usecase.dart';

class DeliveryState {
  final String name;
  final String phone;
  final String address;
  final double? latitude;
  final double? longitude;
  final bool payWithCard;
  final String cardName;
  final String cardNumber;
  final String cvc;
  final bool isSubmitting;

  DeliveryState({
    this.name = "",
    this.phone = "",
    this.address = "",
    this.latitude,
    this.longitude,
    this.payWithCard = false,
    this.cardName = "",
    this.cardNumber = "",
    this.cvc = "",
    this.isSubmitting = false,
  });

  DeliveryState copyWith({
    String? name,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
    bool? payWithCard,
    String? cardName,
    String? cardNumber,
    String? cvc,
    bool? isSubmitting,
  }) {
    return DeliveryState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      payWithCard: payWithCard ?? this.payWithCard,
      cardName: cardName ?? this.cardName,
      cardNumber: cardNumber ?? this.cardNumber,
      cvc: cvc ?? this.cvc,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class DeliveryCubit extends Cubit<DeliveryState> {
  final ProcessDeliveryUseCase processDelivery;

  DeliveryCubit({required this.processDelivery}) : super(DeliveryState());

  void setName(String name) => emit(state.copyWith(name: name));
  void setPhone(String phone) => emit(state.copyWith(phone: phone));
  void setAddress(String address) => emit(state.copyWith(address: address));
  void setLocation(double lat, double lng) =>
      emit(state.copyWith(latitude: lat, longitude: lng));
  void setPayWithCard(bool val) => emit(state.copyWith(payWithCard: val));
  void setCardName(String val) => emit(state.copyWith(cardName: val));
  void setCardNumber(String val) => emit(state.copyWith(cardNumber: val));
  void setCvc(String val) => emit(state.copyWith(cvc: val));

  Future<void> submit() async {
    emit(state.copyWith(isSubmitting: true));

    // Here you can call your use case to save the delivery info
    final info = DeliveryInfo(
      recipientName: state.name,
      phoneNumber: state.phone,
      address: state.address,
      latitude: state.latitude,
      longitude: state.longitude,
      payWithCard: state.payWithCard,
      cardName: state.cardName,
      cardNumber: state.cardNumber,
      cvc: state.cvc,
    );

    await processDelivery.call(info);

    emit(state.copyWith(isSubmitting: false));
  }
}
