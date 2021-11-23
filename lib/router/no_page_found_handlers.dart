import 'package:fluro/fluro.dart';
import 'package:frontend_ascendere_platform/ui/views/no_page_found_view.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    return const NoPageFoundView();
  });
}
