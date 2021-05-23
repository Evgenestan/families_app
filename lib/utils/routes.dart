import 'package:families_app/pages/home/home_page.dart';
import 'package:families_app/pages/parents/add_parents_page.dart';
import 'package:families_app/pages/parents/parent_page.dart';
import 'package:fluro/fluro.dart';

const PARENTID = ':parentId';

class Routes {
  static _To to = _To();
  static FluroRouter router = FluroRouter();

  final homeHandler = Handler(handlerFunc: (_, __) => HomePage());
  final addParentHandler = Handler(handlerFunc: (_, __) => AddParentPage());
  final parentHandler = Handler(handlerFunc: (_, params) => ParentPage(parentId: _extractParam<int>(params, PARENTID)));

  void defineRoutes() {
    router.notFoundHandler = Handler(handlerFunc: (_, __) {
      print('ROUTE WAS NOT FOUND !!!');
      return HomePage();
    });

    router.define(to.home(), handler: homeHandler, transitionType: TransitionType.cupertino);
    router.define(to.addParent(), handler: addParentHandler, transitionType: TransitionType.cupertino);
    router.define(to.parent(parentId: PARENTID), handler: parentHandler, transitionType: TransitionType.cupertino);
  }
}

class _To {
  String home() => '/';
  String addParent() => '/parents/add';
  String parent({required String parentId}) => '/parents/$parentId';
  //static String child(String id) => '/children/$id';
}

class ParameterNotFound {}

dynamic _extractParam<T>(Map<String, List<String>> params, String key) {
  final param = params[key.replaceAll(':', '')];
  if (param != null) {
    if (T is int) {
      return int.parse(param[0]);
    }
    return param[0];
  }
  throw (ParameterNotFound());
}
