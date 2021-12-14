abstract class BaseViewModel extends BaseViewModelInPuts
    with BaseViewModelOutPuts {}

abstract class BaseViewModelInPuts {
  void start();
  void dispose();
}

abstract class BaseViewModelOutPuts {}
