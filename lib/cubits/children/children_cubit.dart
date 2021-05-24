import 'package:families_app/cubits/children/children_state.dart';
import 'package:families_app/models/relatives/child.dart';
import 'package:families_app/repositories/children/children_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChildrenCubit extends Cubit<ChildrenState> {
  ChildrenCubit({required ChildrenRepository childrenRepository})
      : _childrenRepository = childrenRepository,
        super(InitialChildrenState());
  final ChildrenRepository _childrenRepository;

  final Set<Child> currentChildren = {};

  Future<void> loadChildren(List<int> ids) async {
    emit(LoadingChildrenState());
    final children = await _childrenRepository.getChildren(ids);
    currentChildren.clear();
    currentChildren.addAll(children);
    emit(LoadedChildrenState(children));
  }

  Future<void> addChild(Child child) async {
    emit(LoadingChildrenState());
    try {
      DateFormat('d.m.y').parse(child.dob);
      if (child.name.isEmpty || child.surname.isEmpty || child.patronymic.isEmpty) {
        emit(InputErrorChildrenState('Все поля обязательны для заполнения'));
        return;
      }
      final id = await _childrenRepository.getNextChildId;
      child = child.copyWith(id: id);
      await _childrenRepository.addChild(child);
      currentChildren.add(child);
      emit(ChildAddedChildrenState(id));
    } on FormatException catch (_) {
      emit(InputErrorChildrenState('Некорректная дата рождения'));
    } catch (e) {
      print(e);
    }
  }

  void init() {
    currentChildren.clear();
  }
}
