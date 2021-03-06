import 'package:families_app/models/relatives/child.dart';
import 'package:families_app/services/children/children_service.dart';

abstract class ChildrenRepository {
  Future<List<Child>> getChildren(List<int> ids);
  Future<void> addChild(Child child);
  Future<int> get getNextChildId;
}

class ChildrenRepositoryImpl implements ChildrenRepository {
  ChildrenRepositoryImpl({required ChildrenService childrenService}) : _childrenService = childrenService;
  final ChildrenService _childrenService;

  @override
  Future<void> addChild(Child child) => _childrenService.addChild(child);

  @override
  Future<List<Child>> getChildren(List<int> ids) async => _childrenService.getChildren(ids);

  @override
  Future<int> get getNextChildId => _childrenService.getNextChildId();
}
