import 'package:families_app/cubits/children/children_state.dart';
import 'package:families_app/models/relatives/child.dart';
import 'package:families_app/repositories/children/children_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildrenCubit extends Cubit<ChildrenState> {
  ChildrenCubit({required ChildrenRepository childrenRepository})
      : _childrenRepository = childrenRepository,
        super(InitialChildrenState());
  final ChildrenRepository _childrenRepository;

  Future<void> loadChildren(List<int> ids) async {
    emit(LoadingChildrenState());
    final children = await _childrenRepository.getChildren(ids);
    emit(LoadedChildrenState(children));
  }

  Future<void> addChild(Child child) async {
    await _childrenRepository.addChild(child);
  }
}
