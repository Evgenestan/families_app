part of 'package:families_app/utils/hive/hive_storage.dart';

mixin Boxes {
  final Map<Type, Box<dynamic>> _boxes = {};

  Future<Box<T>> _openBox<T>(
    String name,
  ) async {
    try {
      final box = await Hive.openBox<T>(name);
      return box;
    } catch (e) {
      await Hive.deleteBoxFromDisk(name);
      final box = await Hive.openBox<T>(name);
      return box;
    }
  }

  Future<void> initBoxes() async {
    Hive.registerAdapter(ParentAdapter());
    Hive.registerAdapter(ChildAdapter());

    final parentsBox = await _openBox<Parent>('parents');
    _boxes[Parent] = parentsBox;
    final childBox = await _openBox<Child>('child');
    _boxes[Child] = childBox;
  }
}
