import 'package:families_app/models/relatives/parent.dart';
import 'package:families_app/utils/hive/hive_storage.dart';

class ParentsService {
  ParentsService(HiveStorage hiveStorage) : _hiveStorage = hiveStorage;

  final HiveStorage _hiveStorage;

  Future<Iterable<Parent>> getParents() async {
    try {
      return await _hiveStorage.getParents();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Parent> getParentById(int id) async {
    final parent = await _hiveStorage.getParent(id);
    if (parent == null) {
      throw Exception();
    }
    return parent;
  }

  Future<void> addParent(Parent parent) async {
    try {
      await _hiveStorage.addParent(parent);
    } catch (e) {
      print(e);
    }
  }
}
