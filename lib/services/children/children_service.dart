import 'package:families_app/models/relatives/child.dart';
import 'package:families_app/utils/hive/hive_storage.dart';

class ChildrenService {
  ChildrenService(HiveStorage hiveStorage) : _hiveStorage = hiveStorage;

  final HiveStorage _hiveStorage;

  Future<List<Child>> getChildren(List<int> ids) async {
    final children = <Child>[];
    for (var id in ids) {
      final child = await _hiveStorage.getChild(id);
      if (child != null) {
        children.add(child);
      }
    }
    return children;
  }

  Future<int> getNextChildId() async {
    try {
      final child = await _hiveStorage.getLastChild();
      return child.id + 1;
    } catch (e) {
      print(e);
    }
    return 0;
  }

  Future<void> addChild(Child child) async => _hiveStorage.addChild(child);
}
