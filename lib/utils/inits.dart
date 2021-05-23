import 'package:families_app/cubits/children/children_cubit.dart';
import 'package:families_app/cubits/parents/parents_cubit.dart';
import 'package:families_app/repositories/children/children_repository.dart';
import 'package:families_app/repositories/parents/parents_repository.dart';
import 'package:families_app/services/children/children_service.dart';
import 'package:families_app/services/parents/parents_service.dart';
import 'package:families_app/utils/hive/hive_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<Set<Cubit>> initCubits() async {
  final hiveStorage = HiveStorage();
  await hiveStorage.isReady;
  final childrenService = ChildrenService(hiveStorage);
  final parentsService = ParentsService(hiveStorage);

  final parentsRepository = ParentsRepositoryImpl(parentsService: parentsService);
  final childrenRepository = ChildrenRepositoryImpl(childrenService: childrenService);
  return {
    ParentsCubit(parentsRepository: parentsRepository),
    ChildrenCubit(childrenRepository: childrenRepository),
  };
}
