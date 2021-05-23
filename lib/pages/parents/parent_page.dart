import 'package:families_app/cubits/children/children_cubit.dart';
import 'package:families_app/cubits/children/children_state.dart';
import 'package:families_app/cubits/parents/parents_cubit.dart';
import 'package:families_app/cubits/parents/parents_state.dart';
import 'package:families_app/models/relatives/child.dart';
import 'package:families_app/models/relatives/parent.dart';
import 'package:families_app/widgets/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key, required this.parentId}) : super(key: key);

  final String parentId;

  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  final List<Child> _children = [];
  late final ParentsCubit _parentsCubit;
  late final ChildrenCubit _childrenCubit;
  Parent? _parent;

  Future<void> _parentListener(BuildContext _, ParentsState state) async {
    if (state is ParentLoadedParentState) {
      _parent = state.parent;
      await _childrenCubit.loadChildren(_parent?.children ?? []);
    }
  }

  Widget _childBuilder(BuildContext context, int index) {
    final child = _children[index];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Info(
            info: {
              'Фамилия': child.surname,
              'Имя': child.name,
              'Отчество': child.patronymic,
              'Дата рождения': child.dob,
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _parentsCubit = BlocProvider.of(context, listen: false);
    _childrenCubit = BlocProvider.of(context, listen: false);
    _parentsCubit.getParentById(int.parse(widget.parentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ParentsCubit, ParentsState>(
        listener: _parentListener,
        builder: (_, state) {
          if (_parent != null) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                Text('Сведения о родителе:', style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: 16),
                Info(
                  info: {
                    'Фамилия': _parent!.surname,
                    'Имя': _parent!.name,
                    'Отчество': _parent!.patronymic,
                    'Дата рождения': _parent!.dob,
                    'Должность': _parent!.position,
                  },
                ),
                const SizedBox(height: 24),
                Text('Дети:', style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: 16),
                BlocBuilder<ChildrenCubit, ChildrenState>(
                  builder: (_, state) {
                    if (_children.isEmpty) {
                      return Text('Отсутствуют', style: Theme.of(context).textTheme.headline4);
                    }
                    return ListView.builder(
                      itemBuilder: _childBuilder,
                      itemCount: _children.length,
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
