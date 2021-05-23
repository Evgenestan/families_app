import 'package:families_app/models/relatives/child.dart';
import 'package:families_app/models/relatives/parent.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'package:families_app/utils/hive/boxes.dart';

class HiveStorage with Boxes {
  HiveStorage() {
    isReady = _init();
  }

  late Future<bool> isReady;

  Future<bool> _init() async {
    await Hive.initFlutter();
    await initBoxes();
    return true;
  }

  Future<Iterable<Parent>> getParents() async {
    final box = _boxes[Parent];
    if (box == null) {
      throw Exception('Parent is unregistered in HiveStorage');
    }
    return box.values.cast();
  }

  Future<Parent?> getParent(int id) async {
    final box = _boxes[Parent];
    if (box == null) {
      throw Exception('Parent is unregistered in HiveStorage');
    }

    return box.get(id);
  }

  Future<Iterable<Child>> getChildren() async {
    final box = _boxes[Child];
    if (box == null) {
      throw Exception('Child is unregistered in HiveStorage');
    }
    return box.values.cast();
  }

  Future<Child?> getChild(int id) async {
    final box = _boxes[Child];
    if (box == null) {
      throw Exception('Child is unregistered in HiveStorage');
    }

    return box.get(id);
  }

  Future<void> addChild(Child child) async {
    final box = _boxes[Child];
    if (box == null) {
      throw Exception('Child is unregistered in HiveStorage');
    }
    return box.put(child.id, child);
  }

  Future<void> addParent(Parent parent) async {
    final box = _boxes[Parent];
    if (box == null) {
      throw Exception('Parent is unregistered in HiveStorage');
    }
    return box.put(parent.id, parent);
  }
}
