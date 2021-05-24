import 'package:families_app/cubits/parents/parents_cubit.dart';
import 'package:families_app/cubits/parents/parents_state.dart';
import 'package:families_app/models/relatives/parent.dart';
import 'package:families_app/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalo_assets/lib.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ParentsCubit _parentCubit;

  Widget _parentBuilder(Parent parent) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.of(context).pushNamed(Routes.to.parent(parentId: parent.id.toString())),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('${parent.surname} ${parent.name}'),
              if (parent.children.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('Детей: ${parent.children.length}'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyPage() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50),
      child: Text(
        'Ваш список пуст.\nЧтобы начать работу с приложением, добавьте родителя',
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _parentCubit = BlocProvider.of(context, listen: false);
    _parentCubit.loadParents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список родителей', style: Theme.of(context).textTheme.headline1),
      ),
      body: BlocBuilder<ParentsCubit, ParentsState>(builder: (context, snapshot) {
        if (_parentCubit.parents.isEmpty) {
          return _buildEmptyPage();
        }
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: _parentCubit.parents.map(_parentBuilder).toList(growable: false),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(Routes.to.addParent()),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Assets.addIconS),
                fit: BoxFit.fill,
              )),
        ),
      ),
    );
  }
}
