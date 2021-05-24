import 'package:families_app/cubits/parents/parents_state.dart';
import 'package:families_app/models/relatives/parent.dart';
import 'package:families_app/repositories/parents/parents_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ParentsCubit extends Cubit<ParentsState> {
  ParentsCubit({required ParentsRepository parentsRepository})
      : _parentsRepository = parentsRepository,
        super(InitialParentState());
  final ParentsRepository _parentsRepository;

  final Set<Parent> parents = {};

  Future<void> loadParents() async {
    emit(LoadingParentState());
    parents.clear();
    parents.addAll(await _parentsRepository.getParents);
    emit(ParentsLoadedParentState());
  }

  Future<void> getParentById(int id) async {
    emit(LoadingParentState());
    final parent = await _parentsRepository.getParentById(id);
    emit(ParentLoadedParentState(parent));
  }

  Future<void> addParent(Parent parent) async {
    emit(LoadingParentState());
    try {
      DateFormat('d.m.y').parse(parent.dob);
      if (parent.name.isEmpty || parent.surname.isEmpty || parent.patronymic.isEmpty || parent.position.isEmpty) {
        emit(InputErrorParentState('Все поля обязательны для заполнения'));
        return;
      }
      await _parentsRepository.addParent(parent.copyWith(id: _parentsRepository.getNextParentId));
      await loadParents();
      emit(ParentAddedParentState());
    } on FormatException catch (_) {
      emit(InputErrorParentState('Некорректная дата рождения'));
    } catch (e) {
      print(e);
    }
  }

  Future<void> addChildToParent({required int parentId, required int childId}) async {
    final parent = await _parentsRepository.getParentById(parentId);
    parent.children.add(childId);
    await _parentsRepository.addParent(parent);
    emit(ChildAddedParentState());
  }
}
