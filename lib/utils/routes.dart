import 'package:families_app/pages/children/add_child_page.dart';
import 'package:families_app/pages/home/home_page.dart';
import 'package:families_app/pages/parents/add_parent_page.dart';
import 'package:families_app/pages/parents/parent_page.dart';
import 'package:fluro/fluro.dart';

const PARENTID = ':parentId';

class Routes {
  static _To to = _To();
  static FluroRouter router = FluroRouter();

  final homeHandler = Handler(handlerFunc: (_, __) => HomePage());
  final addParentHandler = Handler(handlerFunc: (_, __) => AddParentPage());
  final parentHandler = Handler(handlerFunc: (_, params) => ParentPage(parentId: _extractParam(params, PARENTID)));
  final addChildHandler = Handler(handlerFunc: (_, params) => AddChildPage(parentId: _extractParam(params, PARENTID)));

  void defineRoutes() {
    router.notFoundHandler = Handler(handlerFunc: (_, __) {
      print('ROUTE WAS NOT FOUND !!!');
      return HomePage();
    });

    router.define(to.home(), handler: homeHandler, transitionType: TransitionType.cupertino);
    router.define(to.addParent(), handler: addParentHandler, transitionType: TransitionType.cupertino);
    router.define(to.parent(parentId: PARENTID), handler: parentHandler, transitionType: TransitionType.cupertino);
    router.define(to.addChild(parentId: PARENTID), handler: addChildHandler, transitionType: TransitionType.cupertino);
  }
}

class _To {
  String home() => '/';
  String addParent() => '/parents/add';
  String parent({required String parentId}) => '/parents/$parentId';
  String addChild({required String parentId}) => '/children/add/$parentId';
}

class ParameterNotFound {}

dynamic _extractParam(Map<String, List<String>> params, String key) {
  final param = params[key.replaceAll(':', '')];
  if (param != null) {
    return param[0];
  }
  throw (ParameterNotFound());
}
