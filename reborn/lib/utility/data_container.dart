

class DataContainer {
  String errorTitleText = "";
  String errorMessage = "";
  String errorButtonTitle = "";

  static final _data = DataContainer._internal();
  DataContainer._internal();
  factory DataContainer() {
    return _data;
  }

  void clearError() {
    errorTitleText = "";
    errorMessage = "";
    errorButtonTitle = "";
  }
}

DataContainer dataContainer = DataContainer._data;