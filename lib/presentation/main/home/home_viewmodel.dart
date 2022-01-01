import 'dart:async';

import 'package:heleapp/domain/model/model.dart';
import 'package:heleapp/domain/usecase/home_usecase.dart';
import 'package:heleapp/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel {
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
}
