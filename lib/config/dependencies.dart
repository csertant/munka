import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> _sharedProviders = [];

List<SingleChildWidget> get stagingProviders {
  return [..._sharedProviders];
}

List<SingleChildWidget> get developmentProviders {
  return [..._sharedProviders];
}
