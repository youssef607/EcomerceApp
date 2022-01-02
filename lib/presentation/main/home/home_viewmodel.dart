import 'dart:async';

import 'package:heleapp/domain/model/model.dart';
import 'package:heleapp/domain/usecase/home_usecase.dart';
import 'package:heleapp/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;
  StreamController _bannersStreamController = BehaviorSubject<List<BannerAd>>();
  StreamController _serviceStreamController = BehaviorSubject<List<Service>>();
  StreamController _storeStreamController = BehaviorSubject<List<Store>>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {}

  @override
  void dispose() {
    _bannersStreamController.close();
    _serviceStreamController.close();
    _storeStreamController.close();
    super.dispose();
  }

//inputs
  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _serviceStreamController.sink;

  @override
  Sink get inputStores => _storeStreamController.sink;

//Outputs
  @override
  // TODO: implement outputBanners
  Stream<List<BannerAd>> get outputBanners => throw UnimplementedError();

  @override
  // TODO: implement outputServices
  Stream<List<Service>> get outputServices => throw UnimplementedError();

  @override
  // TODO: implement outputStores
  Stream<List<Store>> get outputStores => throw UnimplementedError();
}

abstract class HomeViewModelInputs {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModelOutputs {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<BannerAd>> get outputBanners;
}
