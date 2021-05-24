import 'package:families_app/models/relatives/parent.dart';
import 'package:families_app/services/parents/parents_service.dart';

abstract class ParentsRepository {
  Future<List<Parent>> get getParents;
  Future<void> addParent(Parent parent);
  int get getNextParentId;
  Future<Parent> getParentById(int id);
}

class ParentsRepositoryImpl implements ParentsRepository {
  ParentsRepositoryImpl({required ParentsService parentsService}) : _parentsService = parentsService;
  final ParentsService _parentsService;

  final List<Parent> _parents = [];

  Future<void> _updateParents() async {
    _parents.clear();
    _parents.addAll(await _parentsService.getParents());
    _parents.sort((a, b) => a.id.compareTo(b.id));
  }

  @override
  Future<List<Parent>> get getParents async {
    if (_parents.isEmpty) {
      await _updateParents();
    }
    return _parents;
  }

  @override
  Future<void> addParent(Parent parent) async {
    await _parentsService.addParent(parent);
    await _updateParents();
  }

  @override
  int get getNextParentId => _parents.isEmpty ? 0 : _parents.last.id + 1;

  @override
  Future<Parent> getParentById(int id) {
    return _parentsService.getParentById(id);
  }
}
