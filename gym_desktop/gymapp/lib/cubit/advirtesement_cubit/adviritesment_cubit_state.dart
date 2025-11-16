import 'package:gymapp/utilis/models/advirtisement.dart';

abstract class AdvertisementState {}

class AdvertisementInitial extends AdvertisementState {}

class AdvertisementLoading extends AdvertisementState {}

class AdvertisementSuccess extends AdvertisementState {
  final String response;
  AdvertisementSuccess(this.response);
}

class AdvertisementGetALLSuccess extends AdvertisementState {
  late List<Advertisement> list;
  AdvertisementGetALLSuccess({required this.list});
}

class AdvertisementError extends AdvertisementState {
  final String message;
  AdvertisementError(this.message);
}
